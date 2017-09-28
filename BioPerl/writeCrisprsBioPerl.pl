#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;

use Bio::Seq;
use Bio::SeqIO;
use Getopt::Long;
use Pod::Usage;

#set variables
my $fasta = '';
my $crispr = '';
my $usage = "\n$0 [options] \n
Options:
	-fasta	Fasta file
	-help	Show this message
\n";

#set options
GetOptions(
	'fasta=s' => \$fasta,
	'crispr=s' => \$crispr,
	help => sub {pod2usage($usage);},
	
) or pod2usage($usage);

#set warnings
unless ($fasta and $crispr) {
	unless ($fasta) {
		print "Specify file for fasta input\n";
		}
	unless ($crispr) {
		print "Specify file for crispr output\n", $usage;
		}
		die $usage
}

#hash to store kmers
my %kMerHash = ();

#hash to store occurrences of last 12 positions
my %last12Counts = ();

#Read in the fasta file
my $seqio_obj = Bio::SeqIO->new(
	-file   => "dmel-all-chromosome-r6.17.fasta",
	-format => 'fasta'
);

#output file
my $seqio_out = Bio::SeqIO->new(
	-file   => ">$crispr",
	-format => 'fasta'
);

#get the sequences from fasta file and process it through sub
while ( my $seq_obj = $seqio_obj->next_seq ) {
	my $seq = $seq_obj->seq;
	#print $seq_obj->desc,"\n";
	processSeq( \$seq );
}

#process sequence and store kmer into hash
sub processSeq {

	my ($sequenceFile) = @_;

	#declare scalars to characterize sliding window
	#Set the size of the sliding window
	my $windowSize = 21;

	#Set the step size
	my $stepSize  = 1;
	my $seqLength = length($$sequenceFile);

#for loop to increment the starting position of the sliding window
#starts at position zero; doesn't move past end of file; advance the window by step size
	for (
		my $windowStart = 0 ;
		$windowStart <= ( $seqLength - $windowSize ) ;
		$windowStart += $stepSize
	  )
	{

	   #Get a 21-mer substring from sequenceRef (two $ to deference reference to
	   #sequence string) starting at the window start for length $windowStart
		my $crisprSeq = substr( $$sequenceFile, $windowStart, $windowSize );

		#print $crisprSeq,"\n";

#if the 21-mer ends in GG, create a hash with key=last 12 of k-mer and value is 21-mer
#Regex where $1 is the crispr, and $2 contains the last 12 of crispr.
		if ( $crisprSeq =~ /([ATGC]{9}([ATGC]{10}GG))$/ ) {

			#Put the crispr in the hash with last 12 as key, full 21 as value.
			$kMerHash{$2} = $1;
			$last12Counts{$2}++;

		}
	}
}

#Initialize the CRISPR count to zero
my $crisprCount = 0;

#Loop through the hash of last 12 counts
for my $last12Seq ( sort ( keys %last12Counts ) ) {

	#Check if count == 1 for this sequence
	if ( $last12Counts{$last12Seq} == 1 ) {

		#The last 12 seq of this CRISPR is unique in the genome.
		#Increment the CRISPR count.
		$crisprCount++;

		#create object to store all the data
		my $seq_obj = Bio::Seq->new(
			-seq        => $kMerHash{$last12Seq},
			-desc       => "CRISPR",
			-display_id => "crispr_$crisprCount",
			-alphabet   => "dna"
		);

		#Print the CRISPR in FASTA format.
		$seqio_out->write_seq($seq_obj);
	}
}