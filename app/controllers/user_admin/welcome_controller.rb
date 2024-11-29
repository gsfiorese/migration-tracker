module UserAdmin
  class WelcomeController < ApplicationController
    include SheetNameSetter

    def index
      set_sheet_names
      @data = if params[:sheet_name].present?
                YearlyMigrationDatum.where(sheet_name: params[:sheet_name])
                                    .order(migration_value: :desc)
                                    .page(params[:page])
                                    .per(15)
              else
                YearlyMigrationDatum.order(created_at: :desc)
                                    .page(params[:page])
                                    .per(15)
              end
    end
  end
end
