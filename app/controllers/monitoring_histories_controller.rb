# -*- coding: utf-8 -*-
class MonitoringHistoriesController < ApplicationController
  def new
  end

  def create
    @monitoring_history = current_user.monitoring_histories.new(monitoring_history_params)
    if @monitoring_history.save
      redirect_to_back
    else
      render :new # TOPページからポストされてきてバリデーションエラーの場合は詳細画面でエラーを表示する仕様にする
      # もしくはboxの中をajaxにする
    end
  end

  def edit
  end

  def update
    @monitoring_history = current_user.monitoring_histories.find_by(recorded_on: monitoring_history_params[:recorded_on])
    if @monitoring_history.update_attributes(monitoring_history_params)
      redirect_to_back
    else
      render :edit # TOPページからポストされてきてバリデーションエラーの場合は詳細画面でエラーを表示する仕様にする
      # もしくはboxの中をajaxにする
    end
  end

  private
  def monitoring_history_params
    params[:monitoring_history].permit(:number_of_steps, :body_weight, :recorded_on)
  end
end
