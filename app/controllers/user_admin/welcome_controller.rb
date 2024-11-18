module UserAdmin
  class WelcomeController < ApplicationController
    def index
      migration_controller = YearlyMigration::YearlyMigrationDataController.new
      result = migration_controller.fetch_data(params)
      @sheet_names = result[:sheet_names]
      @data = result[:data]
    end
  end
end
