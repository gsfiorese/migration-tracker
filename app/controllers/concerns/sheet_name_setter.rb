module SheetNameSetter
  extend ActiveSupport::Concern

  private

  def set_sheet_names
    @sheet_names = YearlyMigrationDatum.distinct.pluck(:sheet_name)
  end
end
