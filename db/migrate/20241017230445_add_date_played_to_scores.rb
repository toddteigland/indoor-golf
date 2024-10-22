class AddDatePlayedToScores < ActiveRecord::Migration[7.1]
  def change
    add_column :scores, :date_played, :date
  end
end
