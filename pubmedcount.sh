#!/bin/bash

for words in $@; do
	SEARCH=$words
	countline="$( wget -qO - "http://www.ncbi.nlm.nih.gov/m/pubmed/?term=${SEARCH}" | grep 'h2 class="c"' )"
	echo $countline
done
