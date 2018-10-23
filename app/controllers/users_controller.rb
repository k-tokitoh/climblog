class UsersController < ApplicationController

  def new
    @user = User.new 
  end

  def show
    @user = User.find(params[:id])
    if ['トライ中','オンサイト','レッドポイント'].include? params[:status]
      @status = params[:status]
      @logs = @user.logs.where(status: @status)
    else
      @logs = @user.logs
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
