#!/bin/bash
trinityPath='/usr/local/programs/trinityrnaseq-2.2.0'
nice -n19 $trinityPath/util/abundance_estimates_to_matrix.pl
