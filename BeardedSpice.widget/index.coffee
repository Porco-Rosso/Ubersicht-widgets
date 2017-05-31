# A widget to describe what's playing


command: "osascript BeardedSpice.widget/Beardedspiceplaying2.scpt"

refreshFrequency: 5000

style: """
  bottom: 0px
  left: 2px
  color: rgba(255, 255, 255, 0.6)
  font-family: Helvetica Neue, Georgia
  font-style: italic
  width: 100%


  p
    padding: 0
    margin: 0
    font-size: 14px
    font-weight: normal

"""

render: (output) -> """
 <p id="BStrack">#{output}</p>
"""

update: (output) ->
  $('#BStrack').text output
