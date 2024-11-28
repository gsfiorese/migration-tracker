module YearlyMigration
  class YearlyMigrationDataController < ApplicationController
    def fetch_data(params)
      sheet_names = YearlyMigrationDatum.distinct.pluck(:sheet_name)

      data = if params[:sheet_name].present?
               YearlyMigrationDatum
                 .where(sheet_name: params[:sheet_name])
                 .order(migration_value: :desc)
                 .page(params[:page]) # Paginated data
                 .per(15) # Paginate top 15 records for the selected sheet_name
      else
               YearlyMigrationDatum
                 .order(created_at: :desc) # Optional: order default view
                 .page(params[:page]) # Paginate data
                 .per(15)
      end

      { sheet_names: sheet_names, data: data }
    end
  end
end
