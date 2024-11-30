class CreateCases < ActiveRecord::Migration[7.2]
  def change
    create_table :cases do |t|
      t.references :users, :countries, :anzsco_codes, :visas,  foreign_key: true
      t.date :lodgement_date, :co_contact_date, :co_response_date, :grant_date, :assess_comence
      t.integer :grant_days, :days_to_co_contact, :days_grant_aftr_co_contact, :work_p_claim, :total_p, :days_aftr_assess
      t.boolean :on_shore, :case_status, :agency, :employment_verification, :active
      t.string :sponsor_state, :documents, :co_contact_type, :engl_prof
      t.timestamps
    end
  end
end
