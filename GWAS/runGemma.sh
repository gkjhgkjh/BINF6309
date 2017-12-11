#!/bin/bash
#Calculate a standardized relatedness matrix
#Perform Eigen-Decomposition of the Relatedness Matrix
#Perform association tests with Univariate Linear Mixed Models and the Wald test.
(nice -n19 gemma -bfile famEpilepsy -gk 2 -o famEpilepsy \
&& nice -n19 gemma -bfile famEpilepsy -k output/famEpilepsy.sXX.txt -eigen -o famEpilepsy \
&& nice -n19 gemma -bfile famEpilepsy -d output/famEpilepsy.eigenD.txt \
-u output/famEpilepsy.eigenU.txt -lmm 1 -o famEpilepsy) \
1>gemma.log 2>gemma.err &

