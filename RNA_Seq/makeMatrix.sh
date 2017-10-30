#!/bin/bash
#save the first argument as xprsDir so the script can be used for both
#genome-guided and de novo
# ./makeMatrix.sh xprs_gg
# ./makeMatrix.sh xprs_dn
xprsDir=$1
#get a list of all results.xpsr files using find
results="$(find $xprsDir -iname results.xprs)"
#clean up the line breaks in the find output by echoing the results
results="$(echo $results)"
#run the trinity abundance_estimates_to_matrix.pl utility using eXpress
#as the estimation method
nice -n19 /usr/local/programs/trinityrnaseq-2.2.0/\
util/abundance_estimates_to_matrix.pl --est_method eXpress \
--cross_sample_norm TMM \
--out_prefix $xprsDir \
--name_sample_by_basedir $results \
1>$xprs.log 2>$xprs.err &
