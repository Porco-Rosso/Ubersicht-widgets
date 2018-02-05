#command: "du -ch ~/.Trash | grep total | cut -c 1-5"
command: "curl -s 'https://api.coinmarketcap.com/v1/ticker/ethereum/' | /usr/local/bin/jq -r .[].percent_change_24h"
#| awk '{print substr($0,8,6)}'

refreshFrequency: 6000

render: (output) -> """
  <div>
    <span>24h Δ</span>
    <span>% </span><a class="size">#{output}</a>
  </div>
"""

style: """
  top: 114px
  left: 02px
  font-size: 16px
  font-family: Inconsolata
  font-weight: 300
  color: rgba(#FFF, 0.3)
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
