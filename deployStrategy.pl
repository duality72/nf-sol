#!/bin/perl

use strict;

my $startDeployTime = shift || &usage;

sub usage {
  print "deployStrategy.pl <startDeployTime>\n";
  die;
}

