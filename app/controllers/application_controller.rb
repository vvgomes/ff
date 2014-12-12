class ApplicationController < ActionController::Base
  helper_method :current_user, :forbid!

  def index
    authenticate!
    @user = current_user
    @tag = params[:tag]
    @accomplishments = Accomplishment.latest
    @accomplishments = @accomplishments.tagged_with(@tag) if @tag
    @accomplishments = @accomplishments.paginate(:page => params[:page])
    @accomplishment = Accomplishment.new
  end
  
  def referer
    username = request.referer.scan(/\/(\w+)$/).join
    username.empty? ? '/' : user_path(username)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate!
    current_user || 
    redirect_to("/auth/saml?redirectUrl=#{URI::encode(request.path)}")
  end

  def forbid!
    render :status => :forbidden, 
      :text => 'You do not have rights to perform this operation.'
  end
end
