#!/bin/bash
#write header lines for the csv files
echo "PairsOut,Sample" > pairsOut.csv
echo "PairsIn,Smple" > pairsIn.csv
#set vaiables for the inPath. outPath and left read suffix
outPath="Paired/"
inPath="/scratch/AiptasiaMiSeq/fastq/"
leftSuffix=".R1.fastq"
#1.use grep to find all the lines starting with @M0 in all the R1.fastq files.
#2.pipe the output to cut and separate columns on :. get the first column.
#3. pipe the output to sort.
#4. pipe the output to sort.
#5. use the -c option to provide a count of the lines collaspsed.
#6. use sed to replace spaces with commas and remove path and suffix from filenames.
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
