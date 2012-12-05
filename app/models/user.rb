# -*- coding: utf-8 -*-
#
class User < ActiveRecord::Base
  has_secure_password # パスワードのバリデーションはついてる
  
  has_many :monitoring_histories

  validates :email, presence: true, uniqueness: true

  def self.authenticate(email, password)
    find_by(email: email).try(:authenticate, password)
  end
end
