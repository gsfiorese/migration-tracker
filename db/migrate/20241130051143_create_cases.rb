class CreateCases < ActiveRecord::Migration[7.2]
  def change
    create_table :cases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :anzsco_code, null: false, foreign_key: true
      t.references :visa, null: false, foreign_key: true
      t.date :lodgement_date
      t.date :co_contact_date
      t.date :co_response_date
      t.date :grant_date
      t.date :assess_commence
      t.integer :grant_days
      t.integer :days_to_co_contact
      t.integer :days_grant_aftr_co_contact
      t.integer :work_p_claim
      t.integer :total_p
      t.integer :days_aftr_assess
      t.boolean :on_shore
      t.boolean :case_status
      t.boolean :agency
      t.boolean :employment_verification
      t.boolean :active
      t.string :sponsor_state
      t.string :documents
      t.string :co_contact_type
      t.string :engl_prof

      t.timestamps
    end
  end
end
