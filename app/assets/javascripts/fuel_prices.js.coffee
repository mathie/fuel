$ ->
  chart = new Highcharts.Chart
    chart:
      renderTo: 'fuel-prices-chart'
      type: 'line'
      events:
        load: ->
          $.ajax '/fuel_prices.json',
            type: 'GET'
            dataType: 'json'
            success: (data) ->
              $.each data, (index, fuel_price) ->
                timestamp = Date.parse(fuel_price["week_begins_on"].replace(/-/g,"/"))
                chart.series[0].addPoint([timestamp, parseFloat(fuel_price["unleaded_price"])], false)
                chart.series[1].addPoint([timestamp, parseFloat(fuel_price["diesel_price"])], false)
                chart.series[2].addPoint([timestamp, parseFloat(fuel_price["unleaded_net_price"])], false)
                chart.series[3].addPoint([timestamp, parseFloat(fuel_price["diesel_net_price"])], false)
                chart.series[4].addPoint([timestamp, parseFloat(fuel_price["fuel_duty"])], false)
              chart.redraw()
    title:
      text: 'Fuel Prices'
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
    series: [
      {
        name: 'Unleaded (Pump price)'
        data: []
      }
      {
        name: 'Diesel (Pump price)'
        data: []
      }
      {
        name: 'Unleaded (Net price)'
        data: []
      }
      {
        name: 'Diesel (net price)'
        data: []
      }
      {
        name: 'Fuel Duty'
        data: []
      }
    ]
