class LikeRelationsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @log = Log.find(params[:log_id])
    current_user.like(@log)
  end

  def destroy
    @log = Log.find(params[:log_id])
    current_user.unlike(@log)
  end
end
