#!/bin/bash
vcf='filteredSnps.vcf'
bam='mergedbam.bam'
fa='vShiloni.fasta'
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T BaseRecalibrator \
-R $fa \
-I $bam \
-knownSites $vcf \
-o recal_data.table \
1>test.log 2>test.err &
