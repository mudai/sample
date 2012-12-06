class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  helper_method :current_user

  private
  def current_user
    warden.user || warden.set_user(User.find_by(remember_me_token: cookies[:remember_me_token]))
  end

  def authenticate_user!
    redirect_to login_path unless current_user
  end

  def warden
    env['warden']
  end
end
