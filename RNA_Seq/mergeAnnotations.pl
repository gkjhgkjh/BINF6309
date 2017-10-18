#!/bin/perl
use warnings;
use strict;
use Bio::SearchIO;

open(OUT,">","aipSwissProt.tsv") or die $!;

my $blastXml = Bio::SearchIO->new(
	-file => 'Trinity-GG.blastp.xml',
	-format => 'blastxml'
);
print OUT join("\t","Trinity", "SwissProt", "SwissProtDesc", "eValue" ),"\n";
while (my $result = $blastXml->next_result() ) {
	my $queryDesc = $result->query_description;
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