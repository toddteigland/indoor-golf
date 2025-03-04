class CreatePlayoffs < ActiveRecord::Migration[7.1]
  def change
    create_table :playoffs do |t|
      t.integer :round
      t.integer :player_1_id
      t.integer :player_2_id
      t.integer :winner_id

      t.timestamps
    end
  end
end
