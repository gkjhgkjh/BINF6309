#!/bin/bash
baseCommand='/usr/local/programs/vcftools_0.1.12b/bin/vcftools'
$baseCommand --vcf filteredSnps.vcf --plink
