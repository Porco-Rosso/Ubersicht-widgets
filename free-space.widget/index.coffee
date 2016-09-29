command: "cd"

#command: "du -ch ~/.Trash | grep total | cut -c 1-5"
command: "df -Hl | grep 'disk1' | awk '{print $4}'"

refreshFrequency: 30000

render: (output) -> """
  <div>
    <img src="free-space.widget/icon.png">
    <a class="size">#{output}</a>
  </div>
"""

style: """
  top: 42px
  left: 02px
  font-size: 16px
  font-family: Inconsolata
  font-weight: 300
  color: rgba(#FFF, 0.5)
  background-color: rgba(#000, 0)
  padding: 4px 6px 4px 6px
  border-radius: 5px

  img
    height: 15px
    margin-bottom: -2px
    padding-right: 0px
    opacity: 0.5;

  a
    margin-left: -3px
"""

update: (output, domEl) ->
  if (output.indexOf(" 0B") > -1)
    $(domEl).find('.size').html("Empty")
  else
    $(domEl).find('.size').html(output)