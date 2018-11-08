class UsersController < ApplicationController

  def new
    @user = User.new 
  end

  def show
    @user = User.find(params[:id])
    # byebug
    if params[:status].present?
      
      @status = params[:status]
      @logs = @user.logs.where(status: @status).order(created_at: :DESC)
    else
      @logs = @user.logs.order(created_at: :DESC)
    end
    counts(@user)
#     @max_grade = ['オンサイト','レッドポイント'].map do |s|
#       [s, User.where(id: @user.id).joins(:logs).where(logs: {status: s}).joins("INNER JOIN problems ON logs.problem_id = proble
# s.id").maximum('grade')]
#     end.to_h
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def counts(user)
    @count_logs = user.logs.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
end