#!/bin/bash
nice -n19 /usr/local/programs/interproscan-5.26-65.0/\
interproscan.sh -appl Pfam -cpu 8 -dp -f XML \
-goterms -i Trinity-GG.fasta.transdecoder.pep \
-iprlookup -pa -o AipIPS.xml \
1>ips.log 2>ips.err &
