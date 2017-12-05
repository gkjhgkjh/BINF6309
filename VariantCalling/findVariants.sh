#!/bin/bash
mkdir -p vcf
#HaplotypeCaller calling SNPs and indels simultaneously via local de-novo assembly of haplotypes in an active region
#--emitRefConfidence records whether the trimming intervals are going to be used to emit reference confidence
#-R reference fasta file
#-I input bam file
#--genotyping_mode DISCOVERY the genotyper will choose the most likely alternate allele
#-stand_call_conf the minimum phred-scaled confidence threshold at which variants should be called
#-nct 16 use 16 threads
#-o output
findVariants(){
for bam in noDup/*.bam
do
vcfOut="${bam/noDup/vcf}"
vcfOut="${vcfOut/bam/vcf}"
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T HaplotypeCaller --emitRefConfidence GVCF -R vShiloni.fasta -I $bam --genotyping_mode DISCOVERY \
-variant_index_type LINEAR -variant_index_parameter 128000 \
-stand_call_conf 30 -nct 16 -o $vcfOut
done
}
findVariants 1>findVariants.log 2>findVariants.err &
