#!/bin/bash
leftReads="$(ls -q Paired/*.R1.fastq)"
leftReads=$(echo $leftReads)
leftReads="${leftReads// /,}"
echo $leftReads
rightReads="$(ls -q Paired/*.R2.fastq)"
rightReads=$(echo $rightReads)
rightReads="${rightReads// /,}"
echo $rightReads
