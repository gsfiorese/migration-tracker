class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :role, :string, default: "member"
    add_column :users, :last_login_at, :datetime
    add_column :users, :status, :string, default: "active"

    add_index :users, :username, unique: true
  end
end
