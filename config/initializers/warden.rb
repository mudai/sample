# -*- coding: utf-8 -*-
Warden::Strategies.add(:password) do
  def authenticate!
    if u = User.authenticate(params[:email], params[:password])
      if params[:remember_me]
        cookies.permanent[:remember_me_token] = u.remember_me_token
      end

      success!(u)
    else
      fail("Invalid email or password")
    end
  end
end

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = lambda { |env| SessionsController.action(:new).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find_by(id: id)
end
