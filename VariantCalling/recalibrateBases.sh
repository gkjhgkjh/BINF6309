#!/bin/bash
vcf='filteredSnps.vcf'
bam='mergedbam.bam'
fa='vShiloni.fasta'
basecommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'
($basecommand \
-T BaseRecalibrator \
-R $fa \
-I $bam \
-knownSites $vcf \
-nct 16 \
-o recal_data.table \
&& $basecommand \
-T BaseRecalibrator \
-R $fa \
-I $bam \
-knownSites $vcf \
-BQSR recal_data.table \
-nct 16 \
-o post_recal_data.table \
&& $basecommand \
-T PrintReads \
-R $fa \
-I $bam \
-BQSR recal_data.table \
-nct 16 \
-o recal_reads.bam) \
1>recal.log 2>recal.err &
