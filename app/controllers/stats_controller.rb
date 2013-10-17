class StatsController < ApplicationController
  def index
    @user = User.find_by_username(params[:username])

    @accomplishment_trends = @user.accomplishment_trends.to_json
    @post_trends = @user.post_trends.to_json
    @tag_counts = @user.tag_counts.to_json

    @accomplishment = Accomplishment.new
    @suggestion = Suggestion.new # shouldnt be here
  end
end
