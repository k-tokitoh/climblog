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
    @log = @problem.logs.new
  end

  # def create
  #   @problem = Problem.new(problem_params)
  #   # byebug
  #   if @problem.save
  #     flash[:success] = '課題を登録しました。'
  #     # @log = params[:log]
  #     @redirect_path = create_log_path(log: log_params)
  #     render "shared/redirect_form", layout: false
  #     # redirect_to :root
  #   else
  #     flash.now[:danger] = '課題の登録に失敗しました。'
  #     @spot = Spot.find(params[:spot][:id])
  #     # byebug
  #     render :new
  #   end
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
