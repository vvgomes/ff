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
    if (@suggestion = try_suggestion params[:id])
     @suggestion.approve!
     @suggestion.save
      Notifier.approval(@suggestion).deliver
     redirect_to '/', notice: 'Suggestion approved!'
    else
      redirect_to '/'
    end
  end

  def edit
    if (@suggestion = try_suggestion params[:id])
      @user = current_user
      @accomplishments = Accomplishment.latest.paginate(:page => params[:page])
      @accomplishment = Accomplishment.new
      render :edit
    else
      redirect_to '/'
    end
  end

  private

  def try_suggestion id
    s = Suggestion.find_by_id id
    current_user.able_to_approve?(s) ? s : nil
  end

end
