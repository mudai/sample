# -*- coding: utf-8 -*-
Warden::Strategies.add(:password) do
  def authenticate!
    # paramsをsymbolでとれない
    u = User.authenticate(params['email'], params['password'])
    u.nil? ? fail("Invalid email or password") : success!(u)
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
  User.find(id)
end
