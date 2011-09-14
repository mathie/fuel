fuel_price_chart = (title, renderTo, series) ->
  if $('#' + renderTo).length > 0
    chart_series = $.map series, (line, i) ->
      {
        name: line['name']
        data: []
      }

    chart = new Highcharts.Chart
      chart:
        renderTo: renderTo
        type: 'line'
        events:
          load: ->
            $.ajax '/fuel_prices.json',
              type: 'GET'
              dataType: 'json'
              success: (data) ->
                $.each data, (index, fuel_price) ->
                  timestamp = Date.parse(fuel_price["week_begins_on"].replace(/-/g,"/"))
                  $.each series, (index, line) ->
                    chart.series[index].addPoint([timestamp, parseFloat(fuel_price[line["json"]])], false)
                chart.redraw()
      title:
        text: title
      tooltip:
        shared: true
        formatter: ->
          s = '<b>' + Highcharts.dateFormat('%A, %b %e, %Y', this.x) + '</b>'
          $.each this.points, (i, point) ->
            s += '<br/>' + point.series.name + ': £' + point.y.toFixed(2)
          s
      plotOptions:
        series:
          marker:
            enabled: false
            states:
              hover:
                enabled: true
      xAxis:
        type: 'datetime'
      yAxis:
        title:
          text: 'Price per litre'
        labels:
          formatter: ->
            "£" + this.value.toFixed(2)
      series: chart_series

$ ->
  fuel_price_chart 'Pump Price per litre', 'pump-prices-chart', [
    {
      name: 'Unleaded'
      json: 'unleaded_price'
    }
    {
      name: 'Diesel'
      json: 'diesel_price'
    }
  ]

  fuel_price_chart 'Net Price per litre', 'net-prices-chart', [
    {
      name: 'Unleaded'
      json: 'unleaded_net_price'
    }
    {
      name: 'Diesel'
      json: 'diesel_net_price'
    }
  ]
