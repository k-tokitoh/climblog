class LogsController < ApplicationController
  # protect_from_forgery except: :create
  
  def index
    if session[:user_id]
      redirect_to user_url(session[:user_id].to_i)
    end
    @logs = Log.includes(:user).all
  end
  
  def new
    @problem = Problem.find(params[:problem_id])
    @log = Problem.find(params[:problem_id]).logs.build
  end

  def create
    # byebug
    # 新規課題の場合
    if params[:problem].present?
      @problem = Problem.new(problem_params)
      @log = Log.new(log_params)
      @spot = @problem.spot
      
      if @problem.save
        @log.problem_id = @problem.id
        @log.user_id = session[:user_id]
        if @log.save
          redirect_to spot_path(@problem.spot)
        end
      end
      render template: 'problems/new'
          
    # 既存課題の場合
    else
      @log = Log.new(log_params)
      if @log.save
        flash[:success] = 'ログを登録しました。'
        # problem = Problem.find(params[:log][:problem_id])
        # redirect_to controller: :logs, action: :create
        # byebug
        redirect_to spot_path(@log.problem.spot)
      else
        flash.now[:danger] = 'ログの登録に失敗しました。'
        @problem = Problem.find(params[:log][:problem_id])
        render :new
      end
    end

    

    
  end
  
  def destroy
    Log.find(params[:id]).destroy
    redirect_to user_path(User.find(session[:user_id]))
  end

  private

  def log_params
    params.require(:log).permit("climbed_at(1i)", "climbed_at(2i)", "climbed_at(3i)", :status, :comment, :problem_id, :user_id, photos: [])
    # params.require(:log).permit("climbed_at(1i)", "climbed_at(2i)", "climbed_at(3i)", :status, :comment, :problem_id, :user_id)
  end
  
  def problem_params
    params.require(:problem).permit(:id, :grade, :type, :spot_id, :name, :description)
  end
end
