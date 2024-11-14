class RemoveExtraGeorgiaGolfClubRounds < ActiveRecord::Migration[6.0]
  def up
        # Delete all but one "Georgia Golf Club" round
    Round.where(course: "Georgia Golf Club").offset(1).destroy_all
  end
end
