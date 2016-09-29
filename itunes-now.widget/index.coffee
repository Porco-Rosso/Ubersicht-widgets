# A widget to describe what's playing in iTunes
# in the form of "Now Playing in iTunes: <song> by <artist> on <album>"
# blagged and edited from:
# http://www.tuaw.com/2007/04/02/terminal-tip-now-playing-info-from-the-command-line/

command: "osascript -e \'tell application \"System Events\" to if name of processes contains \"iTunes\" then tell application \"iTunes\" to if player state is playing then \" \" & name of current track & \" - \" & artist of current track'"

refreshFrequency: 1000

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
 <p>#{output}</p>
"""
