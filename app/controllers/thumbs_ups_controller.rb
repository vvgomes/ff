class ThumbsUpsController < ApplicationController

  def create
    raw = params[:thumbs_up]
    acc = Accomplishment.find_by_id raw[:accomplishment_id]
    if current_user.give_thumbs_up(acc).save
      redirect_to referer, :notice => '+1 Thumbs Up!'
    else
      redirect_to referer
    end
  end

end
