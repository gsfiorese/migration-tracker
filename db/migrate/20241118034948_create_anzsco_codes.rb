class CreateAnzscoCodes < ActiveRecord::Migration[7.2]
  def change
    create_table :anzsco_codes do |t|
      t.integer :anzsco_code
      t.string :occupation
      t.text :description

      t.timestamps
    end
  end
end
