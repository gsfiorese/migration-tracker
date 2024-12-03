class AddAboutToVisas < ActiveRecord::Migration[7.2]
  def change
    add_column :visas, :about, :string
  end
end
