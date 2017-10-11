#!/bin/sh
ls bam/*.sorted.bam >banIn.txt
samtools merge -b banIn.txt AipAll.bam \
1>merge.log 2>merge.err &
