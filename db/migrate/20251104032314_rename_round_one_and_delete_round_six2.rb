class UpdateRoundOneAndDeleteRoundSix2 < ActiveRecord::Migration[7.1]
  class Round < ApplicationRecord; end

  def up
    Round.find_by(round_number: 1)&.update!(course: "Kapalua Plantation")
    Round.find_by(round_number: 6)&.destroy
  end

  def down
    Round.find_by(round_number: 1)&.update!(course: "TBD Round 1")
    Round.create!(round_number: 6, course: "TBD Round 6") unless Round.find_by(round_number: 6)
  end
end
