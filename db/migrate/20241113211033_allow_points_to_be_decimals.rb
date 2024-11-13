class AllowPointsToBeDecimals < ActiveRecord::Migration[7.1]
  def change
    change_column :scores, :points, :decimal, precision: 4, scale: 1
  end
end
