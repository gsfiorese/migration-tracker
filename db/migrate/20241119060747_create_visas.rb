class CreateVisas < ActiveRecord::Migration[7.2]
  def change
    create_table :visas do |t|
      t.string :visa_name
      t.integer :subclass

      t.timestamps
    end
  end
end
