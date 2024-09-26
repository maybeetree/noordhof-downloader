#!/bin/bash

# https://pdfsplitter.blob.core.windows.net/pdf/production/split-books/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX_87_88.pdf

baseurl="https://pdfsplitter.blob.core.windows.net/pdf/production/split-books/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX_"

pdfnum=0
page=1
while true
do
	for step in {0..40}
	do
		page2=$(expr $page + $step)
		pdffile="capt/$(printf "%.4i" $pdfnum).pdf"
		url="${baseurl}${page}_${page2}.pdf"

		printf "Try %.4i - %.4i ..." "$page" "$page2"
		wget --quiet "$url" --output-document "$pdffile"

		if [ $? -eq 0 ]; then
			echo "Got it!"
			page=$(expr $page2 + 1)
			pdfnum=$(expr $pdfnum + 1)
			break
		else
			echo "Nope!"
		fi
	done
	if [ $step -ge 40 ]
	then
		echo "Looks like this is the end of the book, exiting"
		break
	fi
done
