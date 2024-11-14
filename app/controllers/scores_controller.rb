class ScoresController < ApplicationController
  before_action :verify_admin, only: [:admin_scores]

  def index
    # @scores = Score.includes(:round, :user).order('users.email, rounds.round_number')
    @scores = current_user.scores.joins(:round).order('rounds.round_number')

  end
#-----------------------------------------------------------------------------------------------------------------------------
  
  def admin_scores
    @scores = Score.all.joins(:round, :user).order('rounds.round_number')
  end
#-----------------------------------------------------------------------------------------------------------------------------

  def new
    @score = Score.new
  end
  def create
    @score = current_user.scores.build(score_params)
    caluclate_net(@score)
    respond_to do |format|
      puts "SCORE", @score.inspect
      if @score.save
        calculate_points(@score.round_id) # Recalculate points on update
        puts "~~~ SCORE WITH POINTS During CREATE ~~~~", @score.inspect
        format.html {redirect_to scores_path, notice: "Score saved successfully"}
      else
        format.html {render :new}
      end
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------

  def edit
    @score = Score.find(params[:id])
  end
  def update
    @score = Score.find(params[:id])
    respond_to do |format|
      if @score.update(score_params)
        # Calculate and save the new net_score first
        caluclate_net(@score)
        @score.save  # Ensure `net_score` is persisted before calculating points
  
        # Calculate points across the round
        calculate_points(@score.round_id)
        
        # Reload the score to ensure points are up-to-date in memory
        @score.reload
        puts '**** Score with points during UPDATE', @score.inspect  # Debugging line
  
        format.html { redirect_to scores_path, notice: "Score was successfully updated" }
      else
        format.html { render :edit }
      end
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------

  def destroy
    @score = Score.find(params[:id])
    round_id = @score.round_id  # Store the round_id before deletion
    @score.destroy!
  
    # Recalculate points for the remaining scores in this round
    calculate_points(round_id)  # Use round_id here
  
    respond_to do |format|
      format.html { redirect_to scores_path, notice: "Score was successfully deleted" }
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------
  

  def score_params 
    params.require(:score).permit(:round_id, :score, :user_id, :date_played)
  end

  private
#-----------------------------------------------------------------------------------------------------------------------------
  
  def caluclate_net(score)
    #if round = 1, net score is score - (handicap * .778), any other round is score - handicap
    if score.round.round_number === 1 
      net_score = score.score - (score.user.handicap * 0.778) 
    else
      net_score = score.score - score.user.handicap
    end
    puts "Net score for #{score.user.email}: #{net_score}, Handicap: #{score.user.handicap}"  # Debugging line
    score.net_score = net_score
  end
#-----------------------------------------------------------------------------------------------------------------------------
  def calculate_points(round_id)
    scores = Score.where(round_id: round_id).order(:net_score)
    
    # Reset points to ensure no residual values
    scores.update_all(points: nil)
    
    points_distribution = [6, 5, 4, 3, 2, 1]  # Array of available points
    index = 0  # Starting position in points distribution
    
    # Group scores by net_score for handling ties
    scores.chunk_while { |prev, curr| prev.net_score == curr.net_score }.each do |tied_scores|
      num_tied = tied_scores.size
  
      # Calculate total points for tied group and distribute evenly, rounding as needed
      points_to_distribute = points_distribution[index, num_tied].sum.to_f
      split_points = (points_to_distribute / num_tied).round(1)  # Round to 1 decimal for consistency
      
      # Assign the calculated points to each score in this tied group
      tied_scores.each do |score|
        score.update(points: split_points)
        puts "**** Updated Score: #{score.inspect}"  # Debugging line for verification
      end
      
      # Move index forward by the size of this tied group
      index += num_tied
    end
  end
  
  
  
  


  def verify_admin
    redirect_to root_path, alert: "Not authorized" unless admin?
  end

end