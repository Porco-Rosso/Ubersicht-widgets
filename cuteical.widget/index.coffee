# Get calendar events on your desktop with cute bullets
# Made by Cara Takemoto
# Using icalBuddy: http://hasseg.org/icalBuddy/
# Requires Python 2.7


options =
  # To enable the widget, set value to true. To disable, false.
  widgetEnable: true


#This command shows all of your events for today and tomorrow

command: "python cuteical.widget/calendar_events_txtbullets.py"


# the refresh frequency s is seconds and m is minutes
refreshFrequency: '60s'

options : options

render: (output) -> "
<div class='wrapper'>#{output}</div>
"

update: (output, domEl) ->

  wrapper_display = $(domEl)

  if @options.widgetEnable

    wrapper_display.find('.wrapper').html(output)
  else
    wrapper_display.hide()



style: """
  font-family: Helvetica Neue
  left: 0px
  top: 220px


  div
    font-size: 14px
    font-family: Inconsolata
    text-shadow: 0 0 1px rgba(#000, 0.8)
    color: rgba(#FFF, 0.7)
    display: block
    width: 320px

  .wrapper
    xxwidth:100%
    display:inline-block

  .title
    font-family: Helvetica Neue
    color: rgba(#FFF, 0.5)
    font-weight: 300
    font-size: 16px

  .event_title
    font-weight: 250
    padding-left: 10px
    margin-left: 1.1em
    text-indent: -1.1em

  .event_time
    font-weight: 200
    padding-left: 30px
    color: rgba(#FFF, 0.5)

  .today
    padding-bottom:0px

  .square
    font-size: 15px
    color: rgba(204,181,252, 1)

  .heart
    font-size: 13px
    color: rgba(244,189,247, 1)

  .circle
    font-size: 15px
    color: rgba(160,242,164, 1)

  .triangle
    font-size: 8px
    color: rgba(255,244,155, 1)

"""
