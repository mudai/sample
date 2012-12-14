# -*- coding: utf-8 -*-
Warden::Strategies.add(:remember_me) do
  def authenticate!
    if u = User.find_by(remember_me_token: cookies[:remember_me_token])
      success!(u)
    else
      pass
    end
  end
end

Warden::Strategies.add(:password) do
  def authenticate!
    if u = User.authenticate(params[:email], params[:password])
      success!(u)
    else
      fail("Invalid email or password")
    end
  end
end

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :remember_me, :password
  manager.failure_app = lambda { |env| SessionsController.action(:new).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find_by(id: id)
end
