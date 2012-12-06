class SessionsController < ApplicationController
  layout false

  skip_before_filter :authenticate_user!, only: [:new, :create]

  def new
    flash.now.alert = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to root_url, notice: "Logged in!"
  end

  def destroy
    warden.logout
    cookies.delete(:remember_me_token)
    redirect_to root_url, notice: "Logged out!"
  end
end
