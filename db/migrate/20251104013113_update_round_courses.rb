class UpdateRoundCourses < ActiveRecord::Migration[7.1]
  # temporary lightweight model so we can access rounds table
  class Round < ApplicationRecord; end

  def up
    # rename round 1 if it exists
    round_one = Round.find_by(round_number: 1)
    round_one.update!(course: "Kapalua Plantation") if round_one

    # delete round 6 if it exists
    Round.find_by(round_number: 6)&.destroy
  end

  def down
    # optional rollback: reset round 1 name and re-create round 6
    round_one = Round.find_by(round_number: 1)
    round_one.update!(course: "TBD Round 1") if round_one

    Round.create!(round_number: 6, course: "TBD Round 6") unless Round.find_by(round_number: 6)
  end
end
