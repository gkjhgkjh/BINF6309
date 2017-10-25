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
	$bioProc{$id} = $name;
}

while (<SP_TO_GO>) {
	chomp;
	my ($swissProt, $go) = split("\t", $_);
	$spToGo{$swissProt}{$go}++;
}
my $count=0;
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
print($count)


#foreach my $swissProt (sort keys %spToGo) {
#	foreach my $go ( sort keys $spToGo{$swissProt}) {
#		print join("\t", $swissProt, $go), "\n";
#	}
#}
