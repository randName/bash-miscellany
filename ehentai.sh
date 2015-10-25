#!/bin/bash

URL="http://g.e-hentai.org/g/460585/99a267df9a/" 
#URL="http://g.e-hentai.org/g/465110/02ef404648/"

PG1U="$( curl -s "${URL}" | grep "Page 1:" | sed 's/.*<a href="\([^"]*\)"><img alt="0\+1".*/\1/' )"

PGU="$PG1U"
NPGU=""

while [ true ]; do
	PG="$( curl -s "${PGU}" | grep prompt )"
	IMGURL="$( sed -e 's|.*\(http://g.e-hentai.org/r/[^)]*\).*|\1|' -e "s/'//g" <<<"$PG" )"
	echo "$PGU $IMGURL"
	NPG="$( sed -e 's/.*id="next"\([^>]*\).*/\1/' -e 's/.*href="\([^"]*\).*/\1/' <<<"$PG" )"
	[ "$NPG" == "$PGU" ] && break
	PGU="$NPG"
done
