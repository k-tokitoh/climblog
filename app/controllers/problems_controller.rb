class ProblemsController < ApplicationController

  def index
    # byebug
    @spot = Spot.find(params[:spot_id])
    @grade = params[:grade]
    @problems = Problem.where(spot_id: params[:spot_id], grade: params[:grade])
  end

  def new
    @spot = Spot.find(params[:spot_id])
    @grade = params[:grade]
    @problem = @spot.becomes(Spot).problems.new
  end

  def create
    @problem = Problem.new(problem_params)

    if @problem.save
      flash[:success] = '課題を登録しました。'
      # byebug
      redirect_to spot_path(@problem.spot)
    else
      flash.now[:danger] = '課題の登録に失敗しました。'
      render :new
    end
  end

  def destroy
    Problem.find(params[:id].to_i).destroy
    redirect_to problems_path(spot_id: params[:spot_id], grade: params[:grade])
  end

  private

  def problem_params
    params.require(:problem).permit(:grade, :type, :spot_id, :name, :description, :photos)
  end

end
