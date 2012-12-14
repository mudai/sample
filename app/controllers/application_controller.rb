class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  helper_method :current_user

  def redirect_to_back(default = root_path)
      redirect_to :back
  rescue ActionController::RedirectBackError
      redirect_to default
  end

  private
  def current_user
    @current_user ||= warden.authenticate
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def warden
    env['warden']
  end

end
