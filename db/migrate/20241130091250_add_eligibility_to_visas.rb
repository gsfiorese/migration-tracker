class AddEligibilityToVisas < ActiveRecord::Migration[7.2]
  def change
    add_column :visas, :eligibility, :string
  end
end
