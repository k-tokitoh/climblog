class AreasController < ApplicationController
  def new
    @area = Area.new
  end
  
  def create
    @area = Area.new(area_params)

    if @area.save
      flash[:success] = '岩場を登録しました。'
      redirect_to spots_path
    else
      flash.now[:danger] = '岩場の登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def area_params
    params.require(:area).permit(:name, :prefecture, :url)
  end
end
