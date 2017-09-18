#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;

use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality;

my $seqiol_obj = Bio::SeqIO->new(
	-file   => "Sample.R1.fastq",
	-format => 'fastq'
	);

my $seqior_obj = Bio::SeqIO->new(
	-file   => "Sample.R2.fastq",
	-format => 'fastq'
	);

my $interleaved = Bio::SeqIO->new(
	-file   => ">Interleaved.fastq",
	-format => 'fastq'
	);
	

while ( my $seql_obj = $seqiol_obj->next_seq ) {
	my $leftTrimmed = $seql_obj -> get_clear_range(20);
	$leftTrimmed->desc($seql_obj->desc());
	$interleaved -> write_seq($leftTrimmed);
	my $seqr_obj = $seqior_obj->next_seq;
	my $rightTrimmed = $seqr_obj -> get_clear_range(20);
	$rightTrimmed->desc($seqr_obj->desc());
	$interleaved -> write_seq($rightTrimmed);
}



	