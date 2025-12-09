    class HomeController < ApplicationController
    # before_action :authenticate_user!
    before_action :set_standings

    def index
      @scores = Score.includes(:round, :user).order('users.email, rounds.round_number')
    end

    def playoffs
      if @standings.nil?|| @standings.size < 4
        return flash.now[:alert] = "Not enough players qualified for playoffs."
      end

      @playoff_players = @standings.first(4).each_with_index.map { |player, index| [player, index + 1] }

      if Playoff.count.zero? # Only seed the bracket if no matchups exist
        Playoff.create!(round: 1, player_1_id: @playoff_players[0][0].id, player_2_id: @playoff_players[3][0].id, player_1_seed: @playoff_players[0][1], player_2_seed: @playoff_players[3][1])
        Playoff.create!(round: 1, player_1_id: @playoff_players[1][0].id, player_2_id: @playoff_players[2][0].id, player_1_seed: @playoff_players[1][1], player_2_seed: @playoff_players[2][1])
      end
    
      @semifinals = Playoff.where(round: 1)
      @finals = Playoff.where(round: 2)
      @playoffs = Playoff.all
    end
    

    def playoff_result
      match = Playoff.find(params[:playoff_id])
      match.update!(winner_id: params[:winner_id])
    
      # If this is the semifinals, create the finals matchup when both matches have winners
      if match.round == 1 && Playoff.where(round: 1, winner_id: nil).empty?
        winners = Playoff.where(round: 1).pluck(:winner_id)
        # Find the original semifinal matches to get the correct seeds
        semifinal_matches = Playoff.where(round: 1)

        # Find which players won each match and their seeds
        player_1 = semifinal_matches.find { |m| m.winner_id == winners[0] }
        player_2 = semifinal_matches.find { |m| m.winner_id == winners[1] }

        Playoff.create!(
          round: 2,
          player_1_id: winners[0],
          player_2_id: winners[1],
          player_1_seed: player_1&.player_1_id == winners[0] ? player_1.player_1_seed : player_1.player_2_seed,
          player_2_seed: player_2&.player_1_id == winners[1] ? player_2.player_1_seed : player_2.player_2_seed
        )
      end
    
      redirect_to playoffs_path, notice: "Winner recorded!"
    end
      

      private

      def set_winner
        if Playoff.where(round: 2, winner_id: nil).empty?
          @winner = Playoff.where(round: 2).first.winner # Assuming only one final match
        end
      end

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
      

      def set_standings
          @standings = calculate_standings.sort_by do |user|
            [
              -(user.total_points || 0),   # primary: total points (descending)
              (user.round_1_net || 0) +    # secondary: sum of net scores (ascending = lower is better)
              (user.round_2_net || 0) +
              (user.round_3_net || 0) +
              (user.round_4_net || 0) +
              (user.round_5_net || 0) +
              (user.round_6_net || 0),
              user.total_score || 0        # tertiary: total raw score (ascending = lower is better)
            ]
          end
        end
      end