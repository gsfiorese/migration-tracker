class AddUserIdToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id  # Optional: Add an index for better query performance
  end
end
