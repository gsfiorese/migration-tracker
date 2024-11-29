class CheckXlsFilesJob < ApplicationJob
  queue_as :default

  def perform
    latest_file = Dir[XLS_FILE_PATH.join("*.xlsx")].max_by { |f| File.mtime(f) }
    unless latest_file && file_newer?(latest_file)
      Rails.logger.info "CheckXlsFilesJob: No new file found or file is not newer. Skipping processing."
      return
    end

    Rails.logger.info "CheckXlsFilesJob: Started processing file #{latest_file}"

    begin
      process_xls_file(latest_file)
      Rails.logger.info "CheckXlsFilesJob: Successfully completed processing file #{latest_file}"
    rescue => e
      Rails.logger.error "CheckXlsFilesJob: Failed to process file #{latest_file} with error: #{e.message}"
      raise e
    end
  end

  private

  def file_newer?(file)
    last_processed_time = YearlyMigrationDatum.maximum(:updated_at) || Time.at(0)
    File.mtime(file) > last_processed_time
  end

  def process_xls_file(file)
    xls = Roo::Excelx.new(file)

    xls.sheets.each do |sheet|
      next if sheet.downcase == "contents" # Skip irrelevant sheets

      xls.default_sheet = sheet
      years = xls.row(1)[2..-1].map(&:to_s)

      xls.each_row_streaming(offset: 1) do |row|
        country_code = row[0]&.cell_value&.to_s
        country_name = row[1]&.cell_value&.to_s
        next unless country_code && country_name

        years.each_with_index do |year, index|
          migration_value = row[index + 2]&.cell_value

          YearlyMigrationDatum.create!(
            financial_year: year,
            country_code: country_code,
            country_name: country_name,
            migration_value: migration_value,
            sheet_name: sheet
          )
        end
      end
    end
  end
end
