#!/bin/bash
nice -n19 blastp -db /blastDB/swissprot \
-query Trinity-GG.fasta.transdecoder.pep \
-outfmt 5 -evalue .001 -num_threads 4 \
-out Trinity-GG.blastp.xml \
1>blastp.log 2>blastp.err &
