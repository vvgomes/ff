class UsersController < ApplicationController

  def index
    @user = User.find_by_username(params[:username])
    @accomplishments = @user.accomplishments.paginate(:page => params[:page])
    @accomplishment = Accomplishment.new
    @scopes = Scope.all
    @suggestion = Suggestion.new
  end

end
