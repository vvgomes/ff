class AccomplishmentsController < ApplicationController
  def create
    raw = params[:accomplishment]
    description = raw[:description]
    receiver = User.find_by_id(raw[:receiver_id])
    scope = Scope.find_by_id(raw[:scope_id])
    @accomplishment = current_user.report_accomplishment(description, receiver, scope)
    if @accomplishment.valid?
      username = request.referer.scan(/\/(\w+)$/).join
      path = username.empty? ? '/' : user_path(username)
      redirect_to path, notice: 'Accomplishment reported!'
    else
      @scopes = Scope.all
      @accomplishments = Accomplishment.latest
      render action: 'index'
    end
  end
end
