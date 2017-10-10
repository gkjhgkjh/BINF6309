#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;

use Bio::Seq;
use Bio::SeqIO;
use Bio::Seq::Quality;
use Getopt::Long;
use Pod::Usage;

#set variables for later input
my $qual = 0;
my $usage = "\n$0 [options] \n
Options:
	-qual	Quality score minimum
	-help	Show this message
\n";
#set options
GetOptions(
	'qual=i' => \$qual,
	help => sub {pod2usage($usage);},
	
) or pod2usage($usage);
#set warnings for file check
unless ($qual) {
		print "Specify quality score cutoff\n", $usage;
		}
		die $usage;
		
print($qual);
