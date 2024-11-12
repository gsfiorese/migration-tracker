class CreateYearlyMigrationDataTable < ActiveRecord::Migration[7.2]
  def change
    create_table :yearly_migration_data do |t|
      t.string :financial_year
      t.string :country_code
      t.string :country_name
      t.integer :migration_value
      t.string :sheet_name

      t.timestamps
    end
  end
end
