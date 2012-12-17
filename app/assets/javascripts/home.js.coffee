# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $.getJSON($('#graph').data('source'), (json) ->
    options =
      chart:
        renderTo: "graph"
      title:
        text: null
      tooltip:
        enabled: false
      legend:
        enabled: false
      xAxis:
        type: 'datetime'
        dateTimeLabelFormats:
          second: '%H:%M:%S',
          minute: '%H:%M',
          hour: '%m/%e %H:%M',
          day: '%y/%m/%e',
          week: '%y/%m/%e',
          month: '%Y/%m',
          year: '(%Y)'
      yAxis: json.yAxis
      series: json.series
    chart = new Highcharts.Chart(options)
  )
