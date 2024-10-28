class HomeController < ApplicationController
before_action :authenticate_user!

  def index
    @scores = Score.all
    @standings = calculate_standings.sort_by do |user|
      user.round_1_net + user.round_2_net + user.round_3_net + 
    user.round_4_net + user.round_5_net + user.round_6_net
    end
  end

  private

  def calculate_standings
    User.joins(scores: :round)
      .select('users.id, users.email, users.handicap,
        MAX(CASE WHEN rounds.round_number = 1 THEN scores.score ELSE 0 END) AS round_1,
        MAX(CASE WHEN rounds.round_number = 2 THEN scores.score ELSE 0 END) AS round_2,
        MAX(CASE WHEN rounds.round_number = 3 THEN scores.score ELSE 0 END) AS round_3,
        MAX(CASE WHEN rounds.round_number = 4 THEN scores.score ELSE 0 END) AS round_4,
        MAX(CASE WHEN rounds.round_number = 5 THEN scores.score ELSE 0 END) AS round_5,
        MAX(CASE WHEN rounds.round_number = 6 THEN scores.score ELSE 0 END) AS round_6,
        MAX(CASE WHEN rounds.round_number = 1 THEN ROUND(scores.score - (users.handicap * .778),0) ELSE 0 END) AS round_1_net,
        MAX(CASE WHEN rounds.round_number = 2 THEN scores.score - users.handicap ELSE 0 END) AS round_2_net,
        MAX(CASE WHEN rounds.round_number = 3 THEN scores.score - users.handicap ELSE 0 END) AS round_3_net,
        MAX(CASE WHEN rounds.round_number = 4 THEN scores.score - users.handicap ELSE 0 END) AS round_4_net,
        MAX(CASE WHEN rounds.round_number = 5 THEN scores.score - users.handicap ELSE 0 END) AS round_5_net,
        MAX(CASE WHEN rounds.round_number = 6 THEN scores.score - users.handicap ELSE 0 END) AS round_6_net,
        SUM(scores.score) AS total_score')
      .group('users.id')
  end
  

end