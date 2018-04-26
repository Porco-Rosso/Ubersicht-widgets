require('./assets/lib/piety')($, document)

## CPU Usage Widget
## Based on https://github.com/Amar1729/nerdbar.widget/blob/master/cpu.coffee

## Colors Used by the chart
colors =
  low: 'rgb(133, 188, 86)'
  med: 'orange'
  high: 'rgb(255,44,37)'
  back: 'rgba(255, 255, 255, 0.3)'

##  Width of the chart
chartWidth = 12

## Try 'pie'
chartType = 'donut'

refreshFrequency: 2000 # ms

command: "ESC=`printf \"\e\"`; ps -A -o %cpu | awk '{s+=$1} END {printf(\"%.1f\",s/8);}'"

render: (output) ->
  """
  <div class="cpu">
    <span class='number'></span>
    <span class="chart"></span>
  </div>
  """

update: (output, el) ->
  cpu = Number(output)
  fill = colors.low

  ## Medium Threshold
  if cpu > 50
    fill = colors.med

  ## High Threshold
  if cpu > 80
    fill = colors.high

  ## Set Text
  $(".cpu .number", el).text("  #{cpu}%")

  ## Set Chart Data
  $(".cpu .chart", el).text("#{cpu}/100").peity chartType,
    fill: [fill, colors.back]
    width: chartWidth


style: """
  right: 340px
  bottom: 17px

  span
    display inline-block

  color: rgba(255, 255, 255, 0.6)
  font: 12px Inconsolata, monospace, Helvetica Neue, sans-serif
  -webkit-font-smoothing: antialiased
  font-weight bold

  svg.peity
    height: 12px
    margin-bottom: -1px;

  .number


  .chart
    vertical-align bottom
    padding-bottom 1px

"""
