class Score < ApplicationRecord

  belongs_to :user
  belongs_to :round

  validates :score, presence: true, numericality: true
  validates :user_id, uniqueness: { scope: :round_id, message: "Can only enter 1 score per round"}
  validates :date_played, presence: true
end
