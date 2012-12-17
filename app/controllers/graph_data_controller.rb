# -*- coding: utf-8 -*-
class GraphDataController < ApplicationController

  class Graph
    def initialize
    end

    def to_json
      {
        xAxis: [
          { categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]},
          { categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]}
        ],
        yAxis: [
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
         ],
        series: [
          {
            name: "hoge",
            color: "#4572A7",
            type: "line",
            yAxis: 0,
            xAxis: 0,
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
          },
          {
            name: "piyo",
            color: "#AA4643",
            yAxis: 1,
            xAxis: 1,
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

