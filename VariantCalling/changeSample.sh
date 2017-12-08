#!/bin/bash
inPath='vcf/'
ext='.vcf'
#replace sample1 to accesion number for samples
for vcf in vcf/*.vcf
do
	sample="${vcf/$inPath/}"
	sample="${sample/$ext/}"
	sed -i -e "s/sample1/$sample/g" $vcf
done
