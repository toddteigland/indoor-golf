class FixRoundsForProduction < ActiveRecord::Migration[7.1]
  # Inner class to access the model in migration
  class Round < ApplicationRecord; end

  def up
    # Ensure rounds 1-5 exist with correct courses
    rounds = {
      1 => "Kapalua Plantation",
      2 => "November Round",
      3 => "December Round",
      4 => "January Round",
      5 => "February Round"
    }

    rounds.each do |number, course_name|
      round = Round.find_or_initialize_by(round_number: number)
      round.update!(course: course_name)
    end

    # Remove round 6 if it exists
    Round.find_by(round_number: 6)&.destroy
  end

  def down
    # Optional: revert back to previous courses if needed
    rounds = {
      1 => "Fairmont Chateau Whistler GC",
      2 => "Georgia Golf Club",
      3 => "Gold Mountain Olympic",
      4 => "Bear Mountain",
      5 => "Wolf Creek Golf Club"
    }

    rounds.each do |number, course_name|
      round = Round.find_or_initialize_by(round_number: number)
      round.update!(course: course_name)
    end

    # Recreate round 6 as TBD
    Round.find_or_create_by(round_number: 6, course: "TBD Course 6")
  end
end
