#!/bin/bash
while true; do
  #run
  timestart=$(date '+%Y/%m/%d %H:%M:%S')
  status=$(docker exec -it shardeum-dashboard operator-cli status | awk '/state:/ {print $NF}')
   echo "Node status: $status"
   if [[ "$status" == *"top"* ]]
   then
  echo "Your node stopped and I am trying to start now: $timestart"
  sleep 2
    # if
  docker exec -it shardeum-dashboard operator-cli start
  sleep 10
  status=$(docker exec -it shardeum-dashboard operator-cli status | awk '/state:/ {print $NF}')
  echo "Node status: $status"
  else
  sleep 1
  fi
   #wait
  sleep 600
done