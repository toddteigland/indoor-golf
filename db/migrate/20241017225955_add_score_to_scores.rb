class AddScoreToScores < ActiveRecord::Migration[7.1]
  def change
    add_column :scores, :score, :integer
  end
end
