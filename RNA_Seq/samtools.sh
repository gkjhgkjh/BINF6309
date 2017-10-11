#!/bin/sh
samtools sort \
Aip02.sam \
-o Aip02.sorted.bam \
1>Aip02.sort.log 2>Aip02.sort.err &
