module YearlyMigration
  class YearlyMigrationDataController < ApplicationController
    before_action :set_sheet_names, only: [:index, :fetch_tab_data]

    # Handles HTML requests for standard views
    def index
      result = fetch_data(params)
      @sheet_names = result[:sheet_names]
      @data = result[:data]

      respond_to do |format|
        format.html # Render the standard index.html.erb
      end
    end

    # Handles JSON requests for tab-based functionality
    def fetch_tab_data
      if params[:s_sheet_name].present?
        # Normalize input and perform the mapping
        sanitized_name = params[:s_sheet_name].strip.titleize
        puts "Sanitized Tab Name: #{sanitized_name}"

        sheet_name = SHEET_NAME_MAPPING[sanitized_name]
        puts "Mapped Sheet Name: #{sheet_name}"

        @data = if sheet_name.present?
                  YearlyMigrationDatum.where(sheet_name: sheet_name)
                                      .order(migration_value: :desc)
                                      .page(params[:page])
                else
                  []
                end
      else
        @data = YearlyMigrationDatum.all
      end

      respond_to do |format|
        format.json do
          render json: { html: render_to_string(partial: "list", formats: [:html], locals: { data: @data }) }
        end
      end
    end


    def fetch_data(params)
      data = if params[:sheet_name].present?
               YearlyMigrationDatum.where(sheet_name: params[:sheet_name])
                                   .order(migration_value: :desc)
                                   .page(params[:page])
                                   .per(15)
             else
               YearlyMigrationDatum.order(created_at: :desc)
                                   .page(params[:page])
                                   .per(15)
             end

      { sheet_names: @sheet_names, data: data }
    end

    private

    def set_sheet_names
      @sheet_names = YearlyMigrationDatum.distinct.pluck(:sheet_name)
    end
  end
end
