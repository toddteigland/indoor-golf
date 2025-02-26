class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :scores

  validates :handicap, numericality: { greater_than_or_equal_to: 0 }

  after_update :recalculate_standings, if: :saved_change_to_handicap?

  private

  def recalculate_standings
    # Instead of calling the method in the Score model, trigger standings update
    HomeController.new.index # Or another way to trigger the standings calculation
  end
end
