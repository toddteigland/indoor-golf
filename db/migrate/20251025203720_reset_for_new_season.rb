class ResetForNewSeason < ActiveRecord::Migration[7.1]
  # Temporary models for use inside migration
  class Round < ApplicationRecord
    self.table_name = 'rounds'
  end

  class Score < ApplicationRecord
    self.table_name = 'scores'
  end

  def up
    # 1️⃣ Delete all scores (start season fresh)
    Score.delete_all

    # 2️⃣ Reset all course names to "TBD Round X"
    Round.order(:id).each_with_index do |round, index|
      round.update(course: "TBD Round #{index + 1}")
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't restore previous data once reset"
  end
end
