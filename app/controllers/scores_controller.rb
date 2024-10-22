class ScoresController < ApplicationController
  
  def index
    @scores = current_user.scores.joins(:round).order('rounds.round_number')
  end

  def new
    @score = Score.new
  end
  def create
    @score = current_user.scores.build(score_params)
    respond_to do |format|
      if @score.save
        format.html {redirect_to scores_path, notice: "Score saved successfully"}
      else
        format.html {render :new}
      end
    end
  end

  def edit
    @score = Score.find(params[:id])
  end
  def update
    @score = Score.find(params[:id])
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to scores_path, notice: "Score was successfully updated" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy!
    respond_to do |format|
      format.html {redirect_to scores_path, notice: "Score was successfully deleted" }
    end
  end

  def score_params 
    params.require(:score).permit(:round_id, :score, :user_id, :date_played)
  end

end