class StatsController < ApplicationController
  def index
    @user = User.find_by_username(params[:username])

    @accomplishment_trends = @user.accomplishment_trends.to_json
    @post_trends = @user.post_trends.to_json
    
    @accomplishment_tag_counts = @user.accomplishment_tag_counts.to_json
    @post_tag_counts = @user.post_tag_counts.to_json

    @accomplishment = Accomplishment.new
    @suggestion = Suggestion.new # shouldnt be here
  end
end
