class SpotsController < ApplicationController
  
  def index
    @spots = Spot.all
  end
  
  def show
    @spot =Spot.find(params[:id])
  end
  
  def new
    @spot = Spot.new
  end
  
  def create
    @spot = Spot.new(spot_params)

    if @spot.save
      flash[:success] = 'ジム・岩場を登録しました。'
      redirect_to @spot.becomes(Spot)
      # render 'show(@spot.becomes(Spot))
    else
      flash.now[:danger] = 'ジム・岩場の登録に失敗しました。'
      render :new
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :type, :adress, :url)
  end

end
