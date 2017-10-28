#!/bin/perl
use warnings;
use strict;
use Bio::SearchIO;

#output file handle
open(OUT,">","aipSwissProt.tsv") or die $!;

#Bio::SearchIO create input "file handle"
my $blastXml = Bio::SearchIO->new(
	-file => 'Trinity-GG.blastp.xml',
	-format => 'blastxml'
);
#print titles for each fields
print OUT join("\t","Trinity", "SwissProt", "SwissProtDesc", "eValue" ),"\n";
#read input file in Bio::SearchIO
while (my $result = $blastXml->next_result() ) {
	my $queryDesc = $result->query_description;
	#match trinity describtion, print it, print swisprot, match swissprot describtions in different format and print it
	if ( $queryDesc =~ /::(.*?)::/) {
		my $queryDescShort	= $1;
		my $hit 				= $result->next_hit;
		if ($hit) {
			print OUT $queryDescShort, "\t";
			print OUT $hit->accession, "\t";
			my $subjectDescription = $hit->description;
			if($subjectDescription =~ /Full=(.*?);/) {
				$subjectDescription=$1;
			}
			if($subjectDescription =~ /Full=(.*?)\[/) {
				$subjectDescription=$1;
			}
			print OUT $subjectDescription, "\t";
			print OUT $hit->significance, "\n";
		}
	}
}
close(OUT);