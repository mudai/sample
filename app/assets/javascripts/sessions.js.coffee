# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $.getJSON("graph_data.json", (json) ->
    chart = new Highcharts.Chart(json)
  )
  #chart = new Highcharts.Chart(
  #  chart:
  #    renderTo: "graph"

    #title:
    #  text: null

    #xAxis: [categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]]
    #yAxis: [
    #  title:
    #    text: null
    #    style:
    #      color: "#4572A7"

    #  labels:
    #    formatter: ->
    #      @value + " 歩"

    #    style:
    #      color: "#4572A7"
    #]

    #tooltip:
    #  enabled: false

    #legend:
    #  enabled: false

    #series: [
    #  name: null
    #  color: "#4572A7"
    #  type: "column"
    #  data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
    #]
  #)
