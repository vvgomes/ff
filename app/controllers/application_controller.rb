class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def index
    @user = current_user
    @accomplishments = Accomplishment.latest
    @accomplishments = @accomplishments.tagged_with(params[:tag]) if params[:tag]
    @accomplishments = @accomplishments.paginate(:page => params[:page])
    @accomplishment = Accomplishment.new
  end
  
  def referer
    username = request.referer.scan(/\/(\w+)$/).join
    username.empty? ? '/' : user_path(username)
  end
end
