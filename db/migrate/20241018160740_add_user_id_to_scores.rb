class AddUserIdToScores < ActiveRecord::Migration[7.1]
  def change
    add_reference :scores, :user, foreign_key: true
  end
end
