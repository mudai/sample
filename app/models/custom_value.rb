# -*- coding: utf-8 -*-
#
class CustomValue < ActiveRecord::Base
  belongs_to :custom_field
  belongs_to :custom_box
end
