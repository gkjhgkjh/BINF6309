#!/bin/bash
bamDir='bam/'
bamSuffix='.bam'
noDupDir='noDup/'
mkdir -p $noDupDir
markDuplicates(){
	for bamFile in $bamDir*$bamSuffix
		do
			outFile="${bamFile/$bamDir/$noDupDir}"
			java -jar /usr/local/bin/picard.jar MarkDuplicates \
			INPUT=$bamFile \
			OUTPUT=$outFile \
			METRICS_FILE=$outFile.metrics.txt
		done
}
markDuplicates 1>markDup.log 2>markDup.err &
