#!/bin/perl
use warnings;
use strict;

open( SP_TO_GO, "<", "spToGo.tsv") or die $!;
open( BIOP, "<", "bioProcess.tsv") or die $!;
open( TRIN_SP_GO, ">", "trinitySpGo.tsv") or die $!;
open(SP,"<","aipSwissProt.tsv") or die $!;

my %spToGo;
my %bioProc;

while (<BIOP>) {
	chomp;
	my ($id, $name) = split("\t", $_);
	$bioProc{$id}{$name}++;
}

while (<SP_TO_GO>) {
	chomp;
	my ($swissProt, $go) = split("\t", $_);
	$spToGo{$swissProt}{$go}++;
}

while (<SP>) {
	chomp;
	my ($trinity, $swissProt, $description, $eValuw) =
		split("\t", $_ );
	if (defined $spToGo{$swissProt} & $bioProc{$spToGo{$swissProt}} ) {
		foreach my $go (sort keys %{$spToGo{$swissProt}}) {
			print TRIN_SP_GO join("\t", $trinity, $description, $swissProt, $go, $bioProc{$spToGo{$swissProt}}), "\n";
		}
	}
}




#foreach my $swissProt (sort keys %spToGo) {
#	foreach my $go ( sort keys $spToGo{$swissProt}) {
#		print join("\t", $swissProt, $go), "\n";
#	}
#}
