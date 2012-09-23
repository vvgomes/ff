class AccomplishmentsController < ApplicationController
  def index
    @accomplishments = Accomplishment.latest
    @accomplishment = Accomplishment.new
    @scopes = Scope.all
  end

  def create
    raw = params[:accomplishment]
    description = raw[:description]
    receiver = User.find_by_id(raw[:receiver_id])
    scope = Scope.find_by_id(raw[:scope_id])
    @accomplishment = current_user.report_accomplishment(description, receiver, scope)
    if @accomplishment.valid?
      redirect_to accomplishments_path, notice: 'Accomplishment reported!'
    else
      @scopes = Scope.all
      @accomplishments = Accomplishment.latest
      render action: 'index'
    end
  end
end
