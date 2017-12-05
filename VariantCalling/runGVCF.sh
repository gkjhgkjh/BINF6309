#!/bin/bash
vcf="$(ls -q vcf/*.vcf)"
inPath='vcf/'
replacement='--variant vcf/'
vcfParam="${vcf//$inPath/$replacement}"
baseCommand='nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar'
$baseCommand -T GenotypeGVCFs -R vShiloni.fasta $vcfParam -nt 16 -o genotype.vcf \
1>gvcf.log 2>gvcf.err &
