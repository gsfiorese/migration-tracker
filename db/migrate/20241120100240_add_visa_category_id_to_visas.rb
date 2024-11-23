class AddVisaCategoryIdToVisas < ActiveRecord::Migration[7.2]
  def change
    add_reference :visas, :visa_category, null: false, foreign_key: true
  end
end
