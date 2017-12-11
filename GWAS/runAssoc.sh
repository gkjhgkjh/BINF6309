#!/usr/bin/bash
#Run PLINK association analysis
nice -n19 plink --bfile famEpilepsy --assoc --adjust --chr-set 38 --out epilepsy.txt
