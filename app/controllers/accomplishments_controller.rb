class AccomplishmentsController < ApplicationController
  def index
    @accomplishments = Accomplishment.order('created_at DESC')
    @accomplishment = Accomplishment.new
    respond_to { |format| format.html }
  end

  def create
    @accomplishment = Accomplishment.new(params[:accomplishment])
    respond_to do |format|
      if @accomplishment.save
        format.html { redirect_to accomplishments_path, notice: 'Accomplishment reported!' }
      else
        format.html { render action: 'new' }
      end
    end
  end  
end
