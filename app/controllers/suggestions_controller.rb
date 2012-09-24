class SuggestionsController < ApplicationController
  def create
    raw = params[:suggestion]
    description = raw[:description]
    receiver = User.find_by_id(raw[:receiver_id])
    @suggestion = current_user.suggest(description, receiver)
    if @suggestion.valid?
      redirect_to accomplishments_path, notice: 'Suggestion sent!'
    else
      @scopes = Scope.all
      @accomplishments = Accomplishment.latest
      render 'accomplishments/index'
    end
  end
end
