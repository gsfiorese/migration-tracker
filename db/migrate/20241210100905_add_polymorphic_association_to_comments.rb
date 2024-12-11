class AddPolymorphicAssociationToComments < ActiveRecord::Migration[7.2]
  def change
    # Only add the polymorphic reference if the columns don't already exist
    unless column_exists?(:comments, :commentable_type)
      add_reference :comments, :commentable, polymorphic: true, null: false, index: true
    end

    # Only add the user reference if it doesn't already exist
    unless column_exists?(:comments, :user_id)
      add_reference :comments, :user, null: false, foreign_key: true
    end
  end
end
