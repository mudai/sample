class PasswordResetsController < ApplicationController
  layout false

  skip_before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

  def new
  end

  def create
    u = User.find_by_email(params[:email])
    u.send_password_reset if u
    redirect_to root_url, notice: "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by!(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by!(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago # FIXME
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, notice: "Password has been reset."
    else
      render :edit
    end
  end
end
