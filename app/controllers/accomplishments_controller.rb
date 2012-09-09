class AccomplishmentsController < ApplicationController
  def index
    @accomplishments = Accomplishment.all
    @accomplishment = Accomplishment.new
    respond_to { |format| format.html }
  end

  def show
    @accomplishment = Accomplishment.find(params[:id])
    respond_to { |format| format.html }
  end

  def new
    @accomplishment = Accomplishment.new
    respond_to { |format| format.html }
  end

  def create
    @accomplishment = Accomplishment.new(params[:accomplishment])
    respond_to do |format|
      if @accomplishment.save
        format.html { redirect_to @accomplishment, notice: 'Accomplishment was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @accomplishment = Accomplishment.find(params[:id])
    respond_to do |format|
      if @accomplishment.update_attributes(params[:accomplishment])
        format.html { redirect_to @accomplishment, notice: 'Accomplishment was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @accomplishment = Accomplishment.find(params[:id])
    @accomplishment.destroy
    respond_to { |format| format.html { redirect_to accomplishments_url } }
  end
end
