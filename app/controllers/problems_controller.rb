class ProblemsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]

  def show
    # spotを見つけられなかった場合の処理も書くこと
    @problem = Problem.find(params[:id])
    @logs = @problem.logs
  end

  def new
    # byebug
    @spot = Spot.find(params[:spot_id])
    @grade = params[:grade]
    @problem = @spot.becomes(Spot).problems.new
    @log = @problem.logs.new
    # byebug
  end

  def create
    @problem = Problem.new(problem_params)
    @log = Log.new(log_params)
    @spot = @problem.spot
    if log_params[:photos].present? && @problem.save
      @log = Log.new(log_params)
      @log.problem_id = @problem.id
      if @log.save
        redirect_to spot_path(@problem.spot)
        return
      end
    end
    flash.now[:danger] = '新規課題の登録には写真の添付が必要です。'
    render :new
  end

  def destroy
    problem = Problem.find(params[:id])
    spot = problem.spot
    problem.destroy
    redirect_to spot_path(spot)
  end

  private

  def problem_params
    params.require(:problem).permit(:id, :grade, :type, :spot_id, :name, :description, photos: [])
  end

end
