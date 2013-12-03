#!/usr/bin/perl

use strict;

my $startDeployTime = shift || &usage;

sub usage {
  print "Usage: deployStrategy.pl <startDeployTime>\n";
  exit 1;
}

