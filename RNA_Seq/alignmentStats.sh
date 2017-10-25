#!/bin/bash
#Create variables to store the sam directory and suffix
samDir="sam/"
samSuffix=".sam"
#write the column headers to the csv file
echo -e "Sample,Total,Aligned,Concordant" > alignmentStats.csv
#loop through sam file
for samFile in $samDir*$samSuffix
do	
	#count the total number of reads in the alignment
	total="$(samtools view -c $samFile)"
	#count the aligned read in the alignment
	mapped="$(samtools view -F4 -c $samFile)"
	#count the reads that aligned in concordant pairs
	paired="$(samtools view -f2 -c $samFile)"
	#remove the directory from the sample name
	sample="${samFile/$samDir/}"
	#remove the suffix from the sample name
	sample="${sample/$samSuffix/}"
	#write the variables in csv format
	echo -e "$sample,$total,$mapped,$paired" >> alignmentStats.csv
done
