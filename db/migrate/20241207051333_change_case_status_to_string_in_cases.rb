class ChangeCaseStatusToStringInCases < ActiveRecord::Migration[7.2]
  def change
    change_column :cases, :case_status, :string
  end
end
