class GymsController < ApplicationController
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
    params.require(:gym).permit(:name, :region)
  end
end
