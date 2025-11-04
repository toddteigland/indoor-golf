class Score < ApplicationRecord
  belongs_to :user
  belongs_to :round

  validates :score, presence: true, numericality: true
  validates :user_id, uniqueness: { scope: :round_id, message: "Can only enter 1 score per round" }
  validates :date_played, presence: true

  def calculate_net
    if self.round.round_number == 1
      raw_net_score = self.score - (self.user.handicap * 0.5)
    else
      raw_net_score = self.score - self.user.handicap
    end
  
    puts "Raw Net Score: #{raw_net_score}" # Debug output
  
    self.net_score = raw_net_score.round(half: :up)
  
    puts "Rounded Net Score: #{self.net_score}" # Debug output
  end
  

  def self.calculate_points(round_id)
    scores = Score.where(round_id: round_id).order(:net_score)

    # Reset points to ensure no residual values
    scores.update_all(points: nil)

    # Define the points distribution for the top 6 players
    max_points_distribution = [6, 5, 4, 3, 2, 1]

    # Group scores by net_score to handle ties
    index = 0  # Start at the beginning of the points distribution array
    scores.chunk_while { |prev, curr| prev.net_score == curr.net_score }.each do |tied_scores|
      num_tied = tied_scores.size

      # If the current index exceeds the available points, assign 0 points to all remaining scores
      if index >= max_points_distribution.size
        tied_scores.each { |score| score.update(points: 0) }
      else
        # Calculate points for this group of tied scores
        points_to_distribute = max_points_distribution[index, num_tied].sum.to_f
        split_points = (points_to_distribute / num_tied).round(1)  # Distribute points evenly among ties

        # Update each score in this tied group with the calculated points
        tied_scores.each { |score| score.update(points: split_points) }

        # Move the index forward by the number of players in the current tie group
        index += num_tied
      end
    end
  end
end
