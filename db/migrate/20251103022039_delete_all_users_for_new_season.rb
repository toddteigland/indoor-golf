class DeleteAllUsersForNewSeason < ActiveRecord::Migration[7.1]
  # Define a lightweight model for this migration
  class User < ApplicationRecord; end

  def up
    puts "Deleting all users for the new season..."
    User.delete_all
    puts "✅ All users deleted successfully."
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Cannot restore deleted users."
  end
end
