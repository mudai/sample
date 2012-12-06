class UsersController < ApplicationController
  layout false

  skip_before_filter :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      warden.set_user(@user)
      redirect_to root_url, notice: "Signed up!"
    else
      render :new
    end
  end

  private
  def user_params
    params[:user].permit(:email, :password, :password_confirmation)
  end
end
