#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;

use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality;

#read left file with SeqIO
my $seqiol_obj = Bio::SeqIO->new(
	-file   => "Sample.R1.fastq",
	-format => 'fastq'
	);

#read Right file with SeqIO
my $seqior_obj = Bio::SeqIO->new(
	-file   => "Sample.R2.fastq",
	-format => 'fastq'
	);

#write interleaved file
my $interleaved = Bio::SeqIO->new(
	-file   => ">Interleaved.fastq",
	-format => 'fastq'
	);
	
#this loop will process seq from left and right, then write them into interleaved file
while ( my $seql_obj = $seqiol_obj->next_seq ) {
	#Trim left seq
	my $leftTrimmed = $seql_obj -> get_clear_range(20);
	#put desc
	$leftTrimmed->desc($seql_obj->desc());
	#write complete left data into file
	$interleaved -> write_seq($leftTrimmed);
	my $seqr_obj = $seqior_obj->next_seq;
	#Trim right seq
	my $rightTrimmed = $seqr_obj -> get_clear_range(20);
	#put desc
	$rightTrimmed->desc($seqr_obj->desc());
	#write complete right data into file
	$interleaved -> write_seq($rightTrimmed);
}



	