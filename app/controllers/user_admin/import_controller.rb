module UserAdmin
  class ImportController < ApplicationController
    before_action :initialize_databases, only: %i[index upload process_import]

    def index
      @tables = []
      @fields = []

      if params[:selected_database].present?
        @selected_database = params[:selected_database]
        @tables = fetch_tables(@selected_database)

        if params[:selected_table].present?
          @selected_table = params[:selected_table]
          @fields = fetch_fields(@selected_database, @selected_table)
        end
      end

      @file_path = params[:file_path]

      if @file_path.present? && File.exist?(@file_path)
        begin
          @file_content = parse_file(@file_path)
          if @file_content.blank? || !@file_content.is_a?(Array) || !@file_content.first.is_a?(Hash)
            raise "File content is invalid or not parsable."
          end
        rescue => e
          Rails.logger.error "Failed to parse file: #{e.message}"
          @file_content = nil
          flash[:error] = "Failed to parse the file. Please upload a valid file."
        end
      else
        @file_content = nil
      end
    end

    def upload
      if params[:file].present?
        uploaded_file = params[:file]
        file_extension = File.extname(uploaded_file.original_filename)

        unless %w[.csv .xls .xlsx].include?(file_extension.downcase)
          flash[:error] = "Invalid file format. Please upload a CSV, XLS, or XLSX file."
          redirect_back_with_params and return
        end

        temp_file_path = Rails.root.join("tmp", "#{SecureRandom.uuid}_#{uploaded_file.original_filename}")
        File.open(temp_file_path, "wb") { |file| file.write(uploaded_file.read) }

        flash[:success] = "File '#{uploaded_file.original_filename}' uploaded successfully!"
        redirect_to user_admin_import_index_path(
          selected_database: params[:selected_database],
          selected_table: params[:selected_table],
          file_path: temp_file_path.to_s
        )
      else
        flash[:error] = "No file selected. Please choose a file to upload."
        redirect_back_with_params
      end
    end

    def process_import
      @selected_table = params[:selected_table]
      mapping = params[:mapping]
      file_path = params[:file_path]

      if @selected_table.blank? || mapping.blank? || file_path.blank? || !File.exist?(file_path)
        flash[:error] = "Invalid input. Please ensure a table, mapping, and file are provided."
        redirect_back_with_params and return
      end

      begin
        model_class = @selected_table.classify.constantize
      rescue NameError
        flash[:error] = "The table #{@selected_table} does not map to a valid Rails model."
        redirect_back_with_params and return
      end

      table_columns = ActiveRecord::Base.connection.columns(@selected_table).map(&:name)
      invalid_columns = mapping.values.reject { |field| table_columns.include?(field) }
      if invalid_columns.any?
        flash[:error] = "Invalid mapping: #{invalid_columns.join(', ')} are not valid columns in #{@selected_table}."
        redirect_back_with_params and return
      end

      file_content = parse_file(file_path)
      if file_content.nil? || file_content.empty?
        flash[:error] = "Failed to process the file. Please try again."
        redirect_back_with_params and return
      end

      chunk_size = 100
      processed_count = 0
      errors = []

      file_content.each_slice(chunk_size).with_index(1) do |chunk, chunk_index|
        begin
          records_to_insert = []
          records_to_update = []

          chunk.each do |row|
            attributes = {}
            mapping.each do |file_column, table_field|
              attributes[table_field] = row[file_column] if table_field.present?
            end

            unique_identifier = attributes.slice(*mapping.values.reject(&:blank?))
            existing_record = model_class.find_by(unique_identifier)

            if existing_record
              existing_record.assign_attributes(attributes)
              records_to_update << existing_record
            else
              records_to_insert << model_class.new(attributes)
            end
          end

          if records_to_insert.any?
            model_class.import(records_to_insert)
            processed_count += records_to_insert.size
          end

          if records_to_update.any?
            model_class.import(
              records_to_update,
              on_duplicate_key_update: {
                conflict_target: mapping.values.reject(&:blank?),
                columns: records_to_update.first.attributes.keys
              }
            )
          end
        rescue => e
          errors << "Chunk #{chunk_index}: #{e.message}"
          Rails.logger.error "Error processing chunk #{chunk_index}: #{e.message}"
        end
      end

      File.delete(file_path) if File.exist?(file_path)

      if errors.empty?
        flash[:success] = "#{processed_count} records successfully processed into #{@selected_table}."
      else
        flash[:error] = "Processed #{processed_count} records with #{errors.size} errors. Check logs for details."
        Rails.logger.error("Import errors: #{errors.join(', ')}")
      end

      redirect_to user_admin_import_index_path
    end

    private

    def initialize_databases
      @databases = [ "migration_tracker_development", "migration_tracker_test", "migration_tracker_production" ]
    end

    # Fetch tables using ActiveRecord
    def fetch_tables(_database)
      ActiveRecord::Base.connection.tables
    end

    # Fetch fields using ActiveRecord
    def fetch_fields(_database, table)
      return [] unless ActiveRecord::Base.connection.table_exists?(table)

      ActiveRecord::Base.connection.columns(table).map do |column|
        {
          column_name: column.name,
          data_type: column.sql_type,
          is_nullable: column.null
        }
      end
    rescue => e
      Rails.logger.error "Error fetching fields for table #{table}: #{e.message}"
      []
    end


    def parse_file(file_path)
      file_extension = File.extname(file_path)
      case file_extension
      when ".csv"
        parse_csv(file_path)
      when ".xls", ".xlsx"
        parse_excel(file_path)
      else
        []
      end
    end

    def parse_csv(file_path)
      content = []
      CSV.foreach(file_path, headers: true) do |row|
        content << row.to_hash
      end
      content
    end

    def parse_excel(file_path)
      content = []
      spreadsheet = Roo::Spreadsheet.open(file_path)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[ header, spreadsheet.row(i) ].transpose]
        content << row
      end
      content
    end

    def redirect_back_with_params
      redirect_to user_admin_import_index_path(
        selected_database: params[:selected_database],
        selected_table: params[:selected_table]
      )
    end
  end
end
