#!/bin/bash

# Ubersicht widget : tsushin
# By Ryuei Sasaki
# 2016
# https://github.com/louixs/tsushin

#### sourcing the paths of the necessary commands that are usually in different paths just to make sure they work
whereAwk=$(which awk)
whereCat=$(which cat)
whereNetstat=$(which netstat)
whereistats=$(which istats)

foundPaths="${whereCat///cat}:${whereAwk///awk}:${whereNetstat///netstat}:${whereistats///istats}"
####
function getnetwork(){
  export PATH="$foundPaths" &&
  /usr/local/bin/istats scan TC0F --value-only > "$1/temp.db" &
  process=$!
  sleep 1.5
  pkill -P $process

  in=$(cat "$1/temp.db" | awk '{print $1}')

  echo $in
}
####

#### the code below handles cases where a user might have copied files of widget to a non-default widget folder
if [ ! -e "$PWD/assets/temp.sh" ]; then
  getnetwork "$PWD"
else
  getnetwork "$PWD"
fi
