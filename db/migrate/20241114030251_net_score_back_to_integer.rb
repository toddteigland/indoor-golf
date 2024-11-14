class NetScoreBackToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :scores, :net_score, :integer
  end
end
