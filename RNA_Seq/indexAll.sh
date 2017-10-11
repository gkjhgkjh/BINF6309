#!/bin/bash
fastqPath="/scratch/AiptasiaMiSeq/fastq/"
for f1 in $fastqPath*.R1.fastq
do
        f2=$(echo $f1 |cut -d'.' -f1)
        num0cc=$(tr -dc '/' <<<"$f2" | awk '{ print length; }')
        ((num0cc ++))
        f3=$(echo $f2 |cut -d'/' -f$num0cc)
	samtools index \
	$f3.sorted.bam \
	1>$f3.index.log 2>$f3.index.err &
done
