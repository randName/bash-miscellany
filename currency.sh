#!/bin/bash

source ~/.config/openexchangerates

API="http://openexchangerates.org/api"
QUERY="${API}/latest.json?app_id=${OPENEXCHANGERATES_APP_ID}"

content="$( curl -s $QUERY )"
echo "$content" > latest.json
# content="$( cat latest.json )"

timestamp="$( grep "timestamp" <<< "$content" | sed 's/[^0-9]//g' )"
rates=$( egrep "(JPY|SGD)" <<< "$content" | sed 's/"//g;s/: /=/;s/,/;/' | tr 'A-Z' 'a-z' )

date -d "@${timestamp}"
bc <<< "${rates} scale=5; jpy/sgd"
bc <<< "${rates} scale=5; 1000*sgd/jpy"
