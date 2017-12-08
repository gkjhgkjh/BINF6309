#!/bin/bash
fa='vShiloni.fasta'
nice -n19 java -jar /usr/local/programs/GenomeAnalysisTK-3.8-0/GenomeAnalysisTK.jar \
-T AnalyzeCovariates \
-nct 16 \
-R $fa \
-before recal_data.table \
-after post_recal_data.table \
-plots recalibration_plots.pdf \
1>plot.log 2>plot.err
