class SuggestionsController < ApplicationController
  def create
    raw = params[:suggestion]
    description = raw[:description]
    receiver = User.find_by_id(raw[:receiver_id])
    @suggestion = current_user.suggest(description, receiver)
    if @suggestion.valid?
      Notifier.suggestion(@suggestion).deliver
      redirect_to user_path(receiver.username), notice: 'Suggestion sent!'
    else
      redirect_to user_path(receiver.username)
    end
  end
end
