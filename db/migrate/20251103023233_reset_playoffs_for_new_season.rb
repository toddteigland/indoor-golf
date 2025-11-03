# db/migrate/20251103_reset_playoffs_for_new_season.rb
class ResetPlayoffsForNewSeason < ActiveRecord::Migration[7.1]
  def up
    execute("DELETE FROM playoffs;")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
