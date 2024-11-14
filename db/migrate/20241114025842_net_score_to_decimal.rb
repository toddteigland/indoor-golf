class NetScoreToDecimal < ActiveRecord::Migration[7.1]
  def change
    change_column :scores, :net_score, :decimal, precision: 8, scale: 2
  end
end
