# Tsushin widget for ubersicht
# network throughput in kB
# Heavily inspired by Dion Munk's work network-throughput http://tracesof.net/uebersicht-widgets/#ubersicht-network-throughput
# please note it assumes that .bash_profile exists in current user's home directory

command: """
if [ ! -e tsushin.sh ]; then
  "$PWD/tsushin_small.widget/tsushin.sh"
else
  "$PWD/tsushin.sh"
fi
"""

# The refresh frequency in milliseconds
refreshFrequency: 2000

# Render gets called after the shell command has executed. The command's output
# is passed in as a string. Whatever it returns will get rendered as HTML.
#
# Change container size to change the sizing of the chart
render: (domEl) -> """
<script src="https://code.highcharts.com/stock/highstock.js"></script>
<div id="container" style="width:200px; height:35px;">Loading ...</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
"""
  
afterRender: (domEl) ->  
  $(domEl).find('#container').highcharts('StockChart'
    colors: ['rgba(255, 255, 255, 0.50)', 'rgba(255, 255, 255, 0.50)']
    chart:   
      marginRight: 1
      marginTop: 1
      marginBottom: 8
      animation: Highcharts.svg
         
      backgroundColor: null
      style:
        color: 'rgba(255, 255, 255, 0.50)'
        fontFamily: 'Inconsolata, hack,  Monaco, Melno, Courier, Helvetica Neue, Osaka'
        fontSize: '8px'
    navigator:
      enabled: false
    rangeSelector:
      enabled:false
      buttons:
        [{
        count: 5
        type: 'minute'
        text: '5M',
        },{
        connt: 10
        type: 'minute'
        text: '10M'
        },{
        type: 'all'
        text: 'All'
        }]
      enabled: false
      inputEnabled: false
      selected:0
      #inputEnabled: false
      #buttonTheme: visibility: 'hidden'
      #labelStyle: visibility: 'hidden'
      
    scrollbar:
      enabled:false

    title:
      #text: 'Network througput (bytes)'
      enabled: false
      style:
        color: 'rgba(255, 255, 255, 0.50)'
        fontSize: '5px'
        fontFamily: 'Inconsolata, hack, Courier, Helvetica Neue, Osaka, Monaco, Melno'

#==============================
# X - AXIS!
# =====================
    xAxis:
      type: 'datetime'
      dateTimeLabelFormats:
        hour: '%I :%p'
        minute: '%I:%M %p'
      #minTickInterval: 600
      #min: 90
        tickPixelInterval: 90
      minRange: 15*24
      labels:
        enabled: true
        #padding: -5
        y: 8
        style:
          color: 'rgba(255, 255, 255, 0.50)'
          fontSize: '10px'
      gridLineColor: null
      lineWidth: 0
      minorGridLineWidth: 0
      minorTickLenght: 0
      tickLength: 0
      xlineColor: 'transparent'
# ==================================
# Y AXIS!
    yAxis:
      offset: -5
      title:
        text: null
        style: color: 'rgba(255, 255, 255, 0.50)'
      plotLines:[{
        value: 0
        width: 0.5
        color: 'rgba(255, 255, 255, 0.50)'
      }]
      labels:
        style:
          color: 'rgba(255, 255, 255, 0.50)'
          fontSize: '8px'
        y: 7

      #tickPosition:"inside"      
      #padding: 0
      #stackLabels: true
      #reserveSpace: false
      showFirstLabel: false
      showLastLabel: true
                
      gridLineColor: null

      legend:
        enabled: false
        verticalAlign: 'top'
        # align: 'top'
        floating: true

      gridLineColor: null

# ===================
# data !! 
    series: [ {
      name: 'Down (kB)'
      lineWidth: 1
      color: '#9659B2'
      data: []
      },
      {
       name: "Up (kB)"
       lineWidth: 1
       color:'#4EA565'
       data:[]
        }]
      
    credits:
      enabled: false
)

update:(output,domEl) ->
  #How to dynamically update data for highcharts/stock
  #http://stackoverflow.com/questions/16061032/highcharts-series-data-array   #http://stackoverflow.com/questions/13049977/how-can-i-get-access-to-a-highcharts-chart-through-a-dom-container
  #http://api.highcharts.com/highstock/Series.addPoint()
  @run '''
    if [ ! -e tsushin.sh ]; then
      "$PWD/tsushin_small.widget/tsushin.sh"
    else
      "$PWD/tsushin.sh"
    fi
   ''', (err, output) ->

      data=output.split(" ");
      dataIn = parseFloat(data[0]);
      dataOut = parseFloat(data[1]);
      console.log(dataIn)
      console.log(dataOut)
      chart=$(domEl).find("#container").highcharts();
      #i=-99;
      time= (new Date).getTime();
      #timeData = time + i * 10000;
      chart.series[0].addPoint([time, dataIn], true);
      chart.series[1].addPoint([time, dataOut], true);

      console.log(err)
      
# the CSS style for this widget, written using Stylus
# (http://learnboost.github.io/stylus/)
style: """
  @font-face
    font-family: 'hack'
    src: url('assets/hack.ttf')
  // https://css-tricks.com/snippets/css/using-font-face/
  // how to use font available in directory

  color: rgba(255, 255, 255, 0.50)
  font-family: Inconsolata hack, Courier, Helvetica Neue, Osaka, Monaco, Melno
  font-weight: 100
  bottom: -5px
  right: 365px
  text-shadow: 0 0 0px rgba(#000, 0)
  font-size: 5px
  white-space: pre
  #container
    -webkit-backdrop-filter: blur(0px)
"""