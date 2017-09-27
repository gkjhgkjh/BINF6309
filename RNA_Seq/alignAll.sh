#!/bin/bash
fastqPath="trimmed/"
for f1 in $fastqPath*.R1.paired.fastq
do
        f2=$(echo $f1 |cut -d'.' -f1)
        num0cc=$(tr -dc '/' <<<"$f2" | awk '{ print length; }')
        ((num0cc ++))
        f3=$(echo $f2 |cut -d'/' -f$num0cc)
        echo \
	nice -n 19 gsnap \
	-A sam \
	-s AiptasiaGmapIIT.iit \
	-D . \
	-d AiptasiaGmapDb \
	$fastqPath$f3.R1.paired.fastq \
	$fastqPath$f3.R2.paired.fastq \
	1>$3.sam 2>$3.err &
done
