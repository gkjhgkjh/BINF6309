#!/bin/sh
nice -n 19 java -jar /usr/local/programs/Trimmomatic-0.36/trimmomatic-0.36.jar PE \
-threads 1 -phred33 \
/scratch/AiptasiaMiSeq/fastq/Aip02.R1.fastq \
/scratch/AiptasiaMiSeq/fastq/Aip02.R2.fastq \
Aip02.R1.paired.fastq \
Aip02.R1.unpaired.fastq \
Aip02.R2.paired.fastq \
Aip02.R2.unpaired.fastq \
HEADCROP:0 \
ILLUMINACLIP:/usr/local/programs/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:20 TRAILING:20 SLIDINGWINDOW:4:30 MINLEN:36 \
1>Aip02.trim.log 2>Aip02.trim.err &
