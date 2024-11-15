  class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @scores = Score.includes(:round, :user).order('users.email, rounds.round_number')
    @standings = calculate_standings.sort_by do |user|
      (user.round_1_points || 0) + 
      (user.round_2_points || 0) + 
      (user.round_3_points || 0) + 
      (user.round_4_points || 0) + 
      (user.round_5_points || 0) + 
      (user.round_6_points || 0)
    end.reverse
  end

  def playoffs
  
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
          MAX(CASE WHEN rounds.round_number = 1 THEN scores.net_score ELSE 0 END) AS round_1_net,
          MAX(CASE WHEN rounds.round_number = 2 THEN scores.net_score ELSE 0 END) AS round_2_net,
          MAX(CASE WHEN rounds.round_number = 3 THEN scores.net_score ELSE 0 END) AS round_3_net,
          MAX(CASE WHEN rounds.round_number = 4 THEN scores.net_score ELSE 0 END) AS round_4_net,
          MAX(CASE WHEN rounds.round_number = 5 THEN scores.net_score ELSE 0 END) AS round_5_net,
          MAX(CASE WHEN rounds.round_number = 6 THEN scores.net_score ELSE 0 END) AS round_6_net,
          MAX(CASE WHEN rounds.round_number = 1 THEN scores.points ELSE 0 END) AS round_1_points,
          MAX(CASE WHEN rounds.round_number = 2 THEN scores.points ELSE 0 END) AS round_2_points,
          MAX(CASE WHEN rounds.round_number = 3 THEN scores.points ELSE 0 END) AS round_3_points,
          MAX(CASE WHEN rounds.round_number = 4 THEN scores.points ELSE 0 END) AS round_4_points,
          MAX(CASE WHEN rounds.round_number = 5 THEN scores.points ELSE 0 END) AS round_5_points,
          MAX(CASE WHEN rounds.round_number = 6 THEN scores.points ELSE 0 END) AS round_6_points,
          SUM(scores.score) AS total_score,
          SUM(scores.points) AS total_points')
        .group('users.id')
    end
    
    
    
    

  end