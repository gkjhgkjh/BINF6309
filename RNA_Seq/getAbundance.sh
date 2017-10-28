#!/usr/bash
transcriptome=$1
outPath=$2
trinityPath='/usr/local/programs/trinityrnaseq-2.2.0'
pairedPath='Paired/'
leftSuffix='.R1.fastq'
rightSuffix='.R2.fastq'
mkdir -p $outPath
logSuffix='.log'
errSuffix='.err'
for leftReads in $pairedPath*$leftSuffix
do
	rightReads="${leftReads/$leftSuffix/$rightSuffix}"
	sample="${leftReads/$pairedPath/}"
	sample="${sample/$leftSuffix/}"
	nice -n19 $trinityPath/util/align_and_estimate_abundance.pl \
	--transcripts $transcriptome --aln_method bowtie2 --est_method eXpress \
	--trinity_mode --output_dir $outPath$sample --seqType fq --SS_lib_type FR \
	--left $leftReads --right $rigthReads --thread_sount 1\
	1>$outPath$sample$logSuffix 2>$outPath$sample$errSuffix &
done
