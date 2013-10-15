class StatsController < ApplicationController
  def index
    @user = User.find_by_username(params[:username])
    @accomplishment = Accomplishment.new
    @suggestion = Suggestion.new # shouldnt be here
  end
end
