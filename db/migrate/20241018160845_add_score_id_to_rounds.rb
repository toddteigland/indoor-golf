class AddScoreIdToRounds < ActiveRecord::Migration[7.1]
  def change
    add_reference :rounds, :score, foreign_key: true
  end
end
