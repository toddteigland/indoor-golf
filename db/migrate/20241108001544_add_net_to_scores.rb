class AddNetToScores < ActiveRecord::Migration[7.1]
  def change
    add_column :scores, :net_score, :integer
  end
end
