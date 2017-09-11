#!/usr/bin/perl
use warnings;
use strict;

use Bio::Seq;

my $seq_obj = Bio::Seq->new(
	-seq      => 'aaaatgggggggggggccccgtt',
	-alphabet => 'dna'
);

print $seq_obj->seq;

