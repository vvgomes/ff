class AccomplishmentsController < ApplicationController
  def index
    @accomplishments = Accomplishment.latest
    @accomplishment = Accomplishment.new
    respond_to { |format| format.html }
  end

  def create
    raw = params[:accomplishment]
    description = raw[:description]
    receiver = User.find_by_id(raw[:receiver_id])
    group = Group.find_by_id(raw[:group_id])
    @accomplishment = current_user.report_accomplishment(description, receiver, group)
    if @accomplishment.valid?
      redirect_to accomplishments_path, notice: 'Accomplishment reported!'
    else
      @accomplishments = Accomplishment.latest
      render action: 'index'
    end
  end
end
