#command: "du -ch ~/.Trash | grep total | cut -c 1-5"
command: "curl -s 'https://coinbin.org/eth/1.63249' | /usr/local/bin/jq -r '.coin.usd' | awk '{print substr($0,0,6)}'"
#| awk '{print substr($0,8,6)}'

refreshFrequency: 6000

render: (output) -> """
  <div>
    <span>Holdings</span>
    <span>$ </span><a class="size">#{output}</a>
  </div>
"""

style: """
  top: 102px
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
