#!/bin/bash
#get the xprs path as the first argument. e.g. xprs_gg/
xprsPath=$1
#set a variable with the xprs output file extension
xprsExt='.err'
#set a variable with the output filename
outFile='tranAlignStats.csv'
#set a variable with the search text around the desired data
searchText='overall alignment rate'
#write a header line in csv format
echo 'Sample,TranAlignPct' > $xprsPath$outFile
#grep the search text and pipe to a while loop to process line-by-line
grep "$searchText" $xprsPath*$xprsExt | while read -r line ;
do
	#remove search test from the output
	line="${line/$searchText/}"
	#remove file path from the output
	line="${line/$xprsPath/}"
	#remove file extansion from the output
	line="${line/$xprsExt/}"
	#relpace colon separator with comma
	line="${line/:/,}"
	#remove % sign
	line="${line/\%/}"
	#append output in csv format
	echo $line >> $xprsPath$outFile
done

