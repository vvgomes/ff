class PlusOnesController < ApplicationController
  def create
    acc = Accomplishment.find_by_id(params[:accomplishment_id])
    current_user.plus_one(acc)
    redirect_to referer, :notice => '+1 given!'
  end
end
