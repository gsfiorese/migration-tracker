class AddDurationToVisas < ActiveRecord::Migration[7.2]
  def change
    add_column :visas, :duration, :string
  end
end
