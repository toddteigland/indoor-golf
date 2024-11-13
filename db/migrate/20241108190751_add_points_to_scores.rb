class AddPointsToScores < ActiveRecord::Migration[7.1]
  def change
    add_column :scores, :points, :integer
  end
end
