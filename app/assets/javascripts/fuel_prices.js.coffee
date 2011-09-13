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
              chart.redraw()
    title:
      text: 'Fuel Prices'
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
        name: 'Unleaded'
        data: []
      }
      {
        name: 'Diesel'
        data: []
      }
    ]
