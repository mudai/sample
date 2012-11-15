# -*- coding: utf-8 -*-
class GraphDataController < ApplicationController

  class Graph
    def initialize
    end

    def to_json
      {
        chart: {
          renderTo: 'graph'
        },
        title: {
          text: "Average Monthly Weather Data for Tokyo"
        },
        xAxis: [
          { categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]}
        ],
        yAxis: [
           {
             title: {
               text: nil,
               style: {
                 color: "#4572A7"
               }
             },
             labels: {
               style: {
                 color: "#4572A7"
               }
             }
           }
         ],
        tooltip: { enabled: false },
        legend: { enabled: false },
        series: [
          {
            name: nil,
            color: "#4572A7",
            type: "column",
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
          }
        ]
      }
    end
  end

  def sample
    render :json => Graph.new.to_json
  end

end

