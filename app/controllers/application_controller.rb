class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to new_user_path
    end
  end
  
  def log_params
    params.require(:log).permit(:climbed_at, :status, :comment, :problem_id, :user_id, photos: [])
  end
end
