class AddSeedsToPlayoffs < ActiveRecord::Migration[7.1]
  def change
    add_column :playoffs, :player_1_seed, :integer
    add_column :playoffs, :player_2_seed, :integer
  end
end
