class RegistrationsController < Devise::RegistrationsController
  def update
    # Remove the password fields from params if they're not present (i.e., not being changed)
    params[:user].delete(:password) unless params[:user][:password].present?
    params[:user].delete(:password_confirmation) unless params[:user][:password_confirmation].present?

    super do |resource|
      if resource.saved_change_to_handicap? # Check if handicap was updated
        update_net_scores_and_points(resource)
      end
    end
  end

  private

  def update_net_scores_and_points(user)
    user.scores.each do |score|
      score.calculate_net  # Recalculate net score
      score.save!  # Save the updated score

      Score.calculate_points(score.round_id)  # Recalculate points for the round
    end
  end
end
