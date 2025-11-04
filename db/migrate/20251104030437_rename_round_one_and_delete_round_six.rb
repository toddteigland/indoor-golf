class RenameRoundOneAndDeleteRoundSix < ActiveRecord::Migration[7.1]
  class Round < ApplicationRecord; end

  def up
    round_one = Round.find_by(round_number: 1)
    round_one.update!(course: "Kapalua Plantation") if round_one

    Round.find_by(round_number: 6)&.destroy
  end

  def down
    round_one = Round.find_by(round_number: 1)
    round_one.update!(course: "TBD Round 1") if round_one

    Round.create!(round_number: 6, course: "TBD Round 6") unless Round.find_by(round_number: 6)
  end
end
