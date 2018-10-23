class LogsController < ApplicationController
  def new
    # @log = Log.new
    @problem = Problem.find(params[:problem_id])
    @log = Problem.find(params[:problem_id]).logs.build
    # byebug
  end  

  def create
    @log = Log.new(log_params)
    # @user.created_at = Time.zone.local(params["date(1i)"].to_i, params[:created_at]["date(2i)"].to_i, params[:created_at]["date(3i)"].to_i)
  
    if @log.save
      flash[:success] = 'ログを登録しました。'
      problem = Problem.find(params[:log][:problem_id])
      redirect_to spot_path(problem.spot)
    else
      flash.now[:danger] = 'ログの登録に失敗しました。'
      @problem = Problem.find(params[:log][:problem_id])
      render :new
    end
  end

  private

  def log_params
    params.require(:log).permit("climbed_at(1i)", "climbed_at(2i)", "climbed_at(3i)", :status, :comment, :problem_id, :user_id)
  end  
end
