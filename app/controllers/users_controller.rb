class UsersController < ApplicationController
  def update
    User.find(params[:id]).update_attributes(params[:user])
    redirect_to accomplishments_path, notice: 'Personal information updated.'
  end
end
