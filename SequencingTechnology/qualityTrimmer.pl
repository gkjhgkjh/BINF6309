#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;

use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality;
use Getopt::Long;
use Pod::Usage;

my $left = '';
my $right = '';
my $interleaved = '';
my $qual = 0;
my $usage = "\n$0 [options] \n
Options:
	-left	Left reads
	-right	Right reads
	-qual	Quality score minimum
	-help	Show this message
\n";

GetOptions(
	'left=s' => \$left,
	'right=s' => \$right,
	'interleaved=s' => \$interleaved,
	'qual=i' => \$qual,
	help => sub {pod2usage($usage);},
	
) or pod2usage($usage);

unless ($left and $right and $qual and $interleaved) {
	unless ($left) {
		print "Specify file for left reads\n";
		}
	unless ($right) {
		print "Specify file for right reads\n";
		}
	unless ($interleaved) {
		print "Specify file for interleaved output\n";
		}
	unless ($qual) {
		print "Specify quality score cutoff\n", $usage;
		}
		die $usage
}



#read left file with SeqIO
my $seqiol_obj = Bio::SeqIO->new(
	-file   => "$left",
	-format => 'fastq'
	);

#read Right file with SeqIO
my $seqior_obj = Bio::SeqIO->new(
	-file   => "$right",
	-format => 'fastq'
	);

#write interleaved file
my $interleavedobj = Bio::SeqIO->new(
	-file   => ">$interleaved",
	-format => 'fastq'
	);
	
#this loop will process seq from left and right, then write them into interleaved file
while ( my $seql_obj = $seqiol_obj->next_seq ) {
	#Trim left seq
	my $leftTrimmed = $seql_obj -> get_clear_range($qual-1);
	#put desc
	$leftTrimmed->desc($seql_obj->desc());
	#write complete left data into file
	$interleavedobj -> write_seq($leftTrimmed);
	my $seqr_obj = $seqior_obj->next_seq;
	#Trim right seq
	my $rightTrimmed = $seqr_obj -> get_clear_range($qual-1);
	#put desc
	$rightTrimmed->desc($seqr_obj->desc());
	#write complete right data into file
	$interleavedobj -> write_seq($rightTrimmed);
}



	