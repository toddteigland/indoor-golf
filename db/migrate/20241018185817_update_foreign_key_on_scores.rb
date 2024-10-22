class UpdateForeignKeyOnScores < ActiveRecord::Migration[7.1]
  def change
    # Remove existing foreign key if it exists
    remove_foreign_key :scores, :users if foreign_key_exists?(:scores, :users)

    # Add a new foreign key with ON DELETE CASCADE
    add_foreign_key :scores, :users, on_delete: :cascade
  end
end
