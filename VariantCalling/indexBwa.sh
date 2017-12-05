#!/bin/bash
#Index database sequences in the FASTA format
#-p Prefix of the output database
#-a is Linear-time algorithm for constructing suffix array.
nice -n19 bwa index -p vShiloni -a is vShiloni.fasta \
1>bwaIndex.log 2>bwaIndex.err &
