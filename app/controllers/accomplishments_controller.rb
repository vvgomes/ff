class AccomplishmentsController < ApplicationController
  def create
    raw = params[:accomplishment]
    description = raw[:description]
    receiver = User.where(:username => raw[:receiver_username]).first
    @accomplishment = current_user.report_accomplishment(description, receiver)
    if @accomplishment.valid?
      Notifier.accomplishment(@accomplishment).deliver
      redirect_to referer, :notice => 'Accomplishment reported'
    else
      redirect_to referer
    end
  end

  def destroy
    acc = Accomplishment.find_by_id(params[:id])
    current_user.delete_accomplishment(acc)
    redirect_to referer, :notice => 'Accomplishment removed'
  end
end
