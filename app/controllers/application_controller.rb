class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def index
    @user = current_user
    @accomplishments = Accomplishment.latest.paginate(:page => params[:page])
    @accomplishment = Accomplishment.new
    @scopes = Scope.all
  end
end
