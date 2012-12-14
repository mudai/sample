# -*- coding: utf-8 -*-
#
class HomeController < ApplicationController
  def index
    @monitoring_history = current_user.monitoring_histories.today.first_or_initialize
    # どうする
  end
end
