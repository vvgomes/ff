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

  def update
    s = Suggestion.find_by_id params[:id]
    if s.receiver == current_user && !s.useful?
     s.approve!
     s.save
     #Notifier.suggestion_approved(s).deliver
     redirect_to '/', notice: 'Suggestion approved!'
    else
      redirect_to '/'
    end
  end

  def edit
    @suggestion = Suggestion.find_by_id params[:id]
  end

end
