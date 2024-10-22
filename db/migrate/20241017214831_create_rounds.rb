class CreateRounds < ActiveRecord::Migration[7.1]
  def change
    create_table :rounds do |t|
      t.integer :round_number
      t.string :course
      
      t.timestamps
    end
  end
end
