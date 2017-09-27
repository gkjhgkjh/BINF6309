#!/bin/sh
nice -n 19 gsnap \
-A sam \
-s AiptasiaGmapIIT.iit \
-D . \
-d AiptasiaGmapDb \
Aip02.R1.paired.fastq \
Aip02.R2.paired.fastq \
1>Aip02.sam 2>Aip02.err &
