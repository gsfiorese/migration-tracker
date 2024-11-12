class CreateLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :logs do |t|
      t.string :log_type        # Type of log (e.g., error, success, info)
      t.text :message           # Descriptive message about the log entry
      t.references :user, foreign_key: true # References the user, optional if user is not always logged in
      t.jsonb :context          # JSON field for storing additional details
      t.integer :status_code    # Status code (e.g., HTTP status)
      t.string :source          # Source of the log (e.g., controller, job, service)

      t.timestamps              # Created_at and updated_at fields
    end
  end
end
