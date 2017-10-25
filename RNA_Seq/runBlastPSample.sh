#!/bin/bash
nice -n19 blastp -db /blastDB/swissprot \
-query subset.pep \
-outfmt 5 -evalue .001 -num_threads 4 \
-out subset.blastp.xml \
1>blastp.log 2>blastp.err &
