class UpdateRoundOneCourseName < ActiveRecord::Migration[7.1]
  class Round < ApplicationRecord; end

  def up
    round = Round.find_by(round_number: 1)
    round.update!(course: "Kapalua Plantation") if round
  end

  def down
    round = Round.find_by(round_number: 1)
    round.update!(course: "TBD Round 1") if round
  end
end
