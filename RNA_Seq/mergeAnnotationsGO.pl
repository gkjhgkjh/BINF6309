#!/bin/perl
use warnings;
use strict;

#setup three input files and one output file
open( SP_TO_GO, "<", "spToGo.tsv") or die $!;
open( BIOP, "<", "bioProcess.tsv") or die $!;
open( TRIN_SP_GO, ">", "trinitySpGo.tsv") or die $!;
open(SP,"<","aipSwissProt.tsv") or die $!;

#declear hash to store info
my %spToGo;
my %bioProc;

#read through bioprocess.tsv and store goid and describtion into hash
while (<BIOP>) {
	chomp;
	my ($id, $name) = split("\t", $_);
	$bioProc{$id} = $name;
}
#read through spToGo and store swissprot and go id into hash both as key
while (<SP_TO_GO>) {
	chomp;
	my ($swissProt, $go) = split("\t", $_);
	$spToGo{$swissProt}{$go}++;
}

#read through aipSwissProt.tsv, acquire four fields in file. 
#match go term swissprot across all three file and print  needed data into output file
while (<SP>) {
	chomp;
	my ($trinity, $swissProt, $description, $eValuw) =
		split("\t", $_ );
	if (defined $spToGo{$swissProt}) {
		foreach my $go (sort keys %{$spToGo{$swissProt}}) {
			if(defined $bioProc{$go}) {
			print TRIN_SP_GO join("\t", $trinity, $description, $swissProt, $go, $bioProc{$go}), "\n";
			}
		}
	}
}

close(SP_TO_GO);
close(BIOP);
close(TRIN_SP_GO);
close(SP);