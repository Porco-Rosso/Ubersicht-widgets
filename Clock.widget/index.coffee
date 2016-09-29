#
# Just The Date widget for Übersicht
# Ruurd Pels
# github.com/ruurd/justthedate
#

#
# Adjust the styles as you like
#
style =
  # Define the maximum width of the widget.
  width: "45%"

  # Define the position, where to display the date.
  # Set properties you don't need to "auto"
  position:
    top:    "-1px"
    bottom: "auto"
    left:   "auto"
    right:  "2px"

  # Font properties
  font:            "'Futura','Helvetica Neue', sans-serif"
  font_color:      "rgba(#FFF, 0.6)"
  font_size:       "16px"
  font_weight:     "800"
  letter_spacing:  "-0.1em"
  line_height:     "1em"
  font_style: 	   "italic"

  # Misc
  text_align:     "right"
  text_transform: "uppercase"

# Do the command - never mind in this case
command: "echo hello date"

# Lower the frequency for more accuracy.
refreshFrequency: (1000 * 30) # (1000 * n) seconds

render: (o) -> """
  <div id="content">
    <span id="date"></span>
  </div>
"""


update: (output, dom) ->
  date   = new Date();
  d = date.getDate();
  m = date.getMonth() + 1;
  y = date.getFullYear();
  h = date.getHours();
  mi = date.getMinutes();
  time_str = ("0" + d).slice(-2) + '-' + ("0" + m).slice(-2) + '-' + y;
  
  h = if h > 12 then h-12 else h;
  
  clock = h + ":" + ("0" + mi).slice(-2);
  $(dom).find("#date").html(clock)


style: """
  top: #{style.position.top}
  bottom: #{style.position.bottom}
  right: #{style.position.right}
  left: #{style.position.left}
  width: #{style.width}
  font-family: #{style.font}
  color: #{style.font_color}
  font-weight: #{style.font_weight}
  text-align: #{style.text_align}
  text-transform: #{style.text_transform}
  font-size: #{style.font_size}
  font-style: #{style.font_style}
  letter-spacing: #{style.letter_spacing}
  font-smoothing: antialiased
  line-height: #{style.line_height}
  font-kerning: auto
"""
