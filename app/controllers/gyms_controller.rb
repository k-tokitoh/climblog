class GymsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @gym = Gym.new
  end
  
  def create
    @gym = Gym.new(gym_params)

    if @gym.save
      flash[:success] = 'ジムを登録しました。'
      redirect_to spots_path
    else
      flash.now[:danger] = 'ジムの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def gym_params
    params.require(:gym).permit(:name, :prefecture, :url)
  end
end
