# -*- coding: utf-8 -*-

class CustomBox < ActiveRecord::Base
  has_many :custom_fields, dependent: :destroy
  has_many :custom_values #custom_fieldsのdependentで削除されるので書かない

  module Type
    Monitoring = 1
  end
end
