#!/bin/bash
leftReads="$(ls -q Paired/*.R1.fastq)"
leftReads=$(echo $leftReads)
leftReads="${leftReads// /,}"
rightReads="$(ls -q Paired/*.R2.fastq)"
rightReads=$(echo $rightReads)
rightReads="${rightReads// /,}"
nice -n19 /usr/local/programs/\
trinityrnaseq-2.2.0/\
Trinity --seqType fq --max_memory 50G --output trinity_de-novo \
--left $leftReads --right $rightReads --CPU 4 \
1>trinity.log 2>trinity.err &
