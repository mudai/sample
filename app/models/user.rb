# -*- coding: utf-8 -*-
#
class User < ActiveRecord::Base
  has_secure_password # パスワードのバリデーションはついてる
  
  has_many :monitoring_histories

  validates :email, presence: true, uniqueness: true
  before_create { generate_token(:remember_me_token) }

  def self.authenticate(email, password)
    find_by(email: email).try(:authenticate, password)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
