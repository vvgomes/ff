class AccomplishmentsController < ApplicationController
  def index
    @accomplishments = Accomplishment.order('created_at DESC')
    @accomplishment = Accomplishment.new
    respond_to { |format| format.html }
  end

  def create
    receiver = User.find_by_id(params[:accomplishment][:receiver_id])
    description = params[:accomplishment][:description]
    @accomplishment = current_user.report_accomplishment_for(receiver, description)

    if @accomplishment.valid?
      redirect_to accomplishments_path, notice: 'Accomplishment reported!'
    else
      render action: 'new'
    end
  end
end
