class LogsController < ApplicationController
  # protect_from_forgery except: :create
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  
  def index
    # byebug
    if params[:filter] == 'Likes'
      @logs = current_user.like_logs.includes(:user).order(created_at: :DESC)
    # elsif params[:filter] == 'Followings'
    #   @logs = current_user.followings.logs.order(created_at: :DESC)
    else
      @logs = Log.includes(:user).all.order(created_at: :DESC)
    end
  end
  
  def new
    @problem = Problem.find(params[:problem_id])
    @log = Problem.find(params[:problem_id]).logs.build
  end

  def create
    @log = Log.new(log_params)
    if @log.save
      flash[:success] = 'ログを登録しました。'
      redirect_to spot_path(@log.problem.spot)
    else
      flash.now[:danger] = 'ログの登録に失敗しました。'
      @problem = Problem.find(params[:log][:problem_id])
      render :new
    end
  end
  
  def destroy
    Log.find(params[:id]).destroy
    redirect_back fallback_location: user_path(current_user)
  end

end
