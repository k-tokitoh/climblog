class ProblemsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy]

  def show
    # spotを見つけられなかった場合の処理も書くこと
    @problem = Problem.find(params[:id])
    @logs = @problem.logs
  end

  def new
    # byebug
    @spot = Spot.find(params[:spot_id])
    @grade = params[:grade]
    @problem = @spot.becomes(Spot).problems.new
    @log = @problem.logs.new
    # byebug
  end

  def create
    @problem = Problem.new(problem_params)
    @log = Log.new(log_params)
    @spot = @problem.spot
    @log.problem_id = Problem.first.id
    
    # logをsaveできなかった場合、登録画面に戻る
    if !@log.save
      render :new
    # logをsaveできた場合を以下で考える
    else
      # logが写真を持っていなかった場合、logを取り消して登録画面に戻る
      if !@log.photos.first
        @log.destroy
        flash.now[:danger] = '新規課題の登録には写真の添付が必要です。'
        render :new
      # logが写真を持っていた場合を以下で考える
      else
        # problemをsaveできなかった場合、logを取り消して登録画面に戻る
        if !@problem.save
          @log.destroy
          render :new
        # problemをsaveできた場合、その課題の詳細画面に遷移する
        else
          Log.find(@log.id).update(problem_id: @problem.id)
          flash[:success] = '課題とログを登録しました。'
          redirect_to problem_path(@problem)
        end
      end
    end  
    #   if @log.photos
    #     if @problem.save
    #       redirect_to spot_path(@problem.spot)
    #       return
    #     end
    #   else
    #     @log.destroy
    #     @log = Log.new(log_params)
    #   end
    # end
    # flash.now[:danger] = '新規課題の登録には写真の添付が必要です。'
    # render :new
    # if log_params[:photos].present? && @problem.save
    #   @log = Log.new(log_params)
    #   @log.problem_id = @problem.id
    #   if @log.save
    #     redirect_to spot_path(@problem.spot)
    #     return
    #   end
    # end
    
  end

  def destroy
    problem = Problem.find(params[:id])
    spot = problem.spot
    problem.destroy
    redirect_to spot_path(spot)
  end

  private

  def problem_params
    params.require(:problem).permit(:id, :grade, :type, :spot_id, :name, :description, photos: [])
  end

end
