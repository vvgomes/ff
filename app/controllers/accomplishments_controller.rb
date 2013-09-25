class AccomplishmentsController < ApplicationController
  def create
    raw = params[:accomplishment]
    description = raw[:description]
    receiver = User.find_by_id(raw[:receiver_id])
    @accomplishment = current_user.report_accomplishment(description, receiver)
    if @accomplishment.valid?
      Notifier.accomplishment(@accomplishment).deliver
      redirect_to referer, notice: 'Accomplishment reported!'
    else
      redirect_to referer
    end
  end
end
