#!usr/bin/perl
use warnings;
use strict;
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