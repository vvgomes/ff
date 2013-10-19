class UsersController < ApplicationController
  def index
    @user = User.find_by_username(params[:username])
    @accomplishments = @user.accomplishments.paginate(:page => params[:page])
    @accomplishment = Accomplishment.new
    @suggestion = Suggestion.new
  end
end
