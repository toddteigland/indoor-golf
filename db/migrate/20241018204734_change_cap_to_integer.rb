class ChangeCapToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :handicap, :integer
  end
end
