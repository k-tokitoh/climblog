class LogsController < ApplicationController
  def new
    @log = Log.new
  end  

  def create
    @log = Log.new(log_params)
  
    if @log.save
      flash[:success] = 'ログを登録しました。'
      # byebug
      # redirect_to problems_path(spot_id: params[:problem][:spot_id], grade: params[:problem][:grade])
    else
      flash.now[:danger] = 'ログの登録に失敗しました。'
      render :new
    end
  end

  private

  def log_params
    params.require(:log).permit(:climed_at, :status, :comment)
  end  
end
