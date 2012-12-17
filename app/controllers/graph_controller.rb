# -*- coding: utf-8 -*-
#
class GraphController < ApplicationController
  def index
    render json: Graph.new(params).to_json
  end

  class Graph
    module Label
      class Base
      end

      class Line < Base
      end
      class Bar < Base
      end

      class NumberOfSteps < Bar
      end
      class BodyWeight < Line
      end
    end
    attr_accessor :series1, :series2, :graph_type, :current_date, :period, :recent
    def initialize(options = {})
      ## x軸左側の項目
      @series1 = options[:series1]
      ## x軸右側の項目
      @series2 = options[:series2]
      ## グラフのタイプ
      # monitoring_history = 日々の記録
      @graph_type = options[:graph_type]
      ## 表示しようとしている日付
      @current_date = options[:current_date]
      ## 表示のタイプ
      # 一週間表示(1week), 一ヶ月(1month), ３カ月(3month), 一年(1year)
      @period = options[:period]
      ## 直近表示をするかどうか？
      # 直近表示の場合は今日を一番左にする
      @recent = options[:recent]
    end

    def y_axis
      # この辺を作る
      # TODO：@series1, @series2からグラフハッシュを作る
      [@series1,@series2].map{|x| x}
      [
        {
          title: {
            text: "歩数(歩)",
            style: {
              color: "#4572A7"
            }
          },
          labels: {
            style: {
              color: "#4572A7"
            }
          }
        },
        {
          title: {
            text: "歩数(歩)",
            style: {
              color: "#AA4643"
            }
          },
          labels: {
            style: {
              color: "#AA4643"
            }
          },
          opposite: true
        }
      ]
    end

    def series
      [
        {
          name: "hoge",
          color: "#4572A7",
          type: "line",
          yAxis: 0,
          data: sample_data
        },
        {
          name: "piyo",
          color: "#AA4643",
          yAxis: 1,
          type: "column",
          data: sample_data
        }
      ]
    end

    def sample_data
      sample = []
      target = Date.today
      31.times do |i|
        sample << [target.to_time.utc.to_i * 1000, rand(100)]
        target = target.next
      end
      sample
    end

    def to_json
      {
        yAxis: y_axis,
        series: series
      }
    end

    private
    def range(date, period)
      range = case period
      when "1week"
        date.beginning_of_week..date.end_of_week
      when "1month"
        date.beginning_of_month..date.end_of_month
      when "3month"
        date.beginning_of_quarter..date.end_of_quarter
      when "1year"
        date.beginning_of_year..date.end_of_year
      else
        raise "nil!"
      end
      range
    end

  end
end
