#!/bin/bash
#write header lines for the csv files
echo "PairsOut,Sample" > pairsOut.csv
echo "PairsIn,Smple" > pairsIn.csv
#set vaiables for the inPath. outPath and left read suffix
outPath="Paired/"
inPath="/scratch/AiptasiaMiSeq/fastq/"
leftSuffix=".R1.fastq"
#
#echo $outPath*$leftSuffix
grep "\@M0" $outPath*$leftSuffix|\
cut -d':' -f1|\
sort|\
uniq -c|\
sed -e "s|^ *||;s| |,|;s|$outPath||;s|$leftSuffix||" >> pairsOut.csv
grep "\@M0" $inPath*$leftSuffix|\
cut -d':' -f1|\
sort|\
uniq -c|\
sed -e "s|^ *||;s| |,|;s|$inPath||;s|$leftSuffix||" >> pairsIn.csv
