class CreateVisaCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :visa_categories do |t|
      t.string :name
      t.string :about

      t.timestamps
    end
  end
end
