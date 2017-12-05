#!/bin/bash
#samtools faidx index reference sequence in FASTA formate or extract subsequence from indexed reference sequence
#and use picard to create dictionary
#R is reference input fasta file and O is output dict
samtools faidx vShiloni.fasta
java -jar /usr/local/bin/picard.jar CreateSequenceDictionary \
R=vShiloni.fasta O=vShiloni.dict \
1>prepRef.log 2>prepRef.err &
