require('./assets/lib/piety')($, document)

# network Network widget
# Based on:
# Tsushin widget for ubersicht
# network network in kB
# Heavily inspired by Dion Munk's work network-network http://tracesof.net/uebersicht-widgets/#ubersicht-network-network

## Colors of chart
colors =
  low: 'rgb(136, 255, 80)'
  med: 'rgb(210, 88, 27)',
  high: 'rgb(245, 6, 6)'


## Width of chart
chartWidth = 40

## Number of data points to on the chart
dataPointCount = 15

## Try 'line'!
chartType = 'line'

chartIn = null
chartOut = null
valuesIn   = (0 for i in [0..dataPointCount])

command: """
if [ ! -e assets/temp.sh ]; then
  "$PWD/temp.widget/assets/temp.sh"
else
  "$PWD/assets/network.sh"
fi
"""

# The refresh frequency in milliseconds
refreshFrequency: 2000

# Change container size to change the sizing of the chart
render: () -> """
<div class='network'>
  <div class='chart-in'></div>
  <br>
  <div class='number'></div>
</div>
"""

update:(output,el) ->

  ## Initialize Charts
  if not chartIn or not chartOut
    chartIn = $(".chart-in", el).peity chartType,
      # fill: [colors.in]
      # stroke: [colors.in]
      width: chartWidth
      min: 70
      max: 120


  @run '''
    if [ ! -e assets/network.sh ]; then
      "$PWD/temp.widget/assets/temp.sh"
    else
      "$PWD/assets/temp.sh"
    fi
   ''', (err, output) ->
      data = output.split(" ");
      dataIn = parseFloat(data[0]);

      if isNaN(dataIn)
        return

      if (dataIn > 90)
        chartIn = $(".chart-in", el).peity chartType,
          fill: [colors.high]
          stroke: [colors.high]
      else if (dataIn > 75)
        chartIn = $(".chart-in", el).peity chartType,
          fill: [colors.med]
          stroke: [colors.med]
      else
        chartIn = $(".chart-in", el).peity chartType,
          fill: [colors.low]
          stroke: [colors.low]


      ## Push the in value on the stack
      valuesIn.shift() if valuesIn.length >= dataPointCount
      valuesIn.push(dataIn)
      chartIn
        .text(valuesIn.join(","))
        .change()

      ## round
      dataIn = Math.round(dataIn)

      units = '°C'

      ## Round to one decimal place
      $('.number', el).html "#{dataIn}<span style='color: #{colors.in};font-weight:bold;padding-right:1px'></span>#{units}"

style: """
  right: 285px
  bottom: 0px

  color: rgba(255, 255, 255, 0.7)
  font: 12px Inconsolata, monospace, Helvetica Neue, sans-serif
  font-weight: 200
  -webkit-font-smoothing: antialiased

  div
    display inline-block

  .number
    vertical-align bottom
    text-align: center
    width 40px
    padding-top: 3px
    padding-bottom: 2px

  svg.peity
    height: 12px

"""
