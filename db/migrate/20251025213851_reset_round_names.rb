class ResetRoundNames < ActiveRecord::Migration[7.1]
  # Temporary model to use in the migration
  class Round < ApplicationRecord; end

  def up
    # Reset all round course names to "TBD Round 1", "TBD Round 2", etc.
    Round.order(:id).each_with_index do |round, index|
      round.update!(course: "TBD Round #{index + 1}")
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
