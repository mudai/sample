# -*- coding: utf-8 -*-
#
class GraphController < ApplicationController
  
  def index
    render json: GraphService.new(current_user, params).create.to_json
  end

  class GraphService
    attr_reader :user, :graph1, :graph2, :series1, :series2, :graph_type, :current_date, :period, :recent

    def initialize(user, options = {})
      ## User
      @user = user
      ## x軸左側の項目
      @series1 = options[:series1]
      ## x軸右側の項目
      @series2 = options[:series2]
      ## グラフのタイプ
      # monitoring_history = 日々の記録
      # とりあえず
      @graph_type = options[:graph_type]
      ## 表示しようとしている日付
      @current_date = options[:current_date]
      ## 表示のタイプ
      # 一週間表示(1week), 一ヶ月(1month), ３カ月(3month), 一年(1year)
      @period = options[:period]
      ## 直近表示をするかどうか？
      # 直近表示の場合は今日を一番左にする
      @recent = options[:recent] || false
    end

    def create
      # 実際にデータをとってきてhash形式にする
      # パフォーマンスが気になり出したらpluckあたりを使う
      # TODO: range
      data1 = get_data(@series1)
      data2 = get_data(@series2)
      @graph1 = layered_graph(@series1, data1, opposite: false)
      @graph2 = layered_graph(@series2, data2, opposite: true)
      self
    end

    def get_data(series)
      records = @user.monitoring_histories.where(:recorded_on => range).to_a
      range.each do |date|
        unless records.find{|x| x.recorded_on == date}
          records << MonitoringHistory.new(recorded_on: date)
        end
      end
      records.sort!{|x, y| x.recorded_on <=> y.recorded_on}
      case series
      when "number_of_step"
        records.map{|x| [x.recorded_on.utc_milli_sec, x.number_of_steps] }
      when "body_weight"
        records.map{|x| [x.recorded_on.utc_milli_sec, x.body_weight] }
      else
        raise "get_data"
      end
    end

    def layered_graph(series, data, options = {})
      klass = ("GraphController::GraphService::HighChart::" + series.classify).constantize
      klass.new(data, options)
    end

    def to_json
      array = [@graph1, @graph2].reject(&:blank?)
      yAxis = array.map(&:to_label)
      series = array.map(&:to_series)
      {
        yAxis: yAxis,
        series: series
      }.to_json
    end

    private
    def range
      date = Date.parse(@current_date)
      range = case @period
      when "1week"
        if @recent
          Date.today.weeks_ago(1)..Date.today
        else
          date.beginning_of_week..date.end_of_week
        end
      when "1month"
        if @recent
          Date.today.months_ago(1)..Date.today
        else
          date.beginning_of_month..date.end_of_month
        end
      when "3month"
        if @recent
          Date.today.months_ago(3)..Date.today
        else
          date.beginning_of_quarter..date.end_of_quarter
        end
      when "1year"
        if @recent
          Date.today.years_ago(1)..Date.today
        else
          date.beginning_of_year..date.end_of_year
        end
      else
        raise "nil!"
      end
      range
    end

    def sample_data
      sample = []
      target = Date.today
      31.times do |i|
        sample << [target.utc_milli_sec, rand(100)]
        target = target.next
      end
      sample
    end
    alias_method :data, :sample_data

    module HighChart
      # グラフの表示まわり(json整形)を司るクラス
      class Base
        attr_accessor :data, :opposite

        def initialize(data, options = {})
          @data = data
          @opposite = options[:opposite] || false
          # 右側のスケールを使う場合は1, 左側は0
          @yAxis = @opposite ? 1 : 0
        end

        def title
          raise "write me!"
        end

        def color
          raise "write me!"
        end

        def type
          raise "write me!"
        end

        def to_label
          {
            title: {
              text: title,
              style: {
                color: color
              }
            },
            labels: {
              style: {
                color: color
              }
            },
            opposite: opposite
          }
        end

        def to_series
          {
            name: title,
            color: color,
            type: type,
            yAxis: @yAxis,
            data: data
          }
        end
      end

      class Line < Base
        def type
          "line"
        end
      end

      class Bar < Base
        def type
          "column"
        end
      end

      class NumberOfStep < Bar
        def title
          "歩数(歩)"
        end

        def color
          "#4572A7"
        end
      end

      class BodyWeight < Line
        def title
          "体重(kg)"
        end

        def color
          "#AA4643"
        end
      end
    end
  end
end
