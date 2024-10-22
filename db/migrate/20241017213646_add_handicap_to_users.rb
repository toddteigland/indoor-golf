class AddHandicapToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :handicap, :decimal, precision: 4, scale: 1
  end
end
