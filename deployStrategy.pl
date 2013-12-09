#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use NFSol;
use NFSol::Functions qw/displayTime/;

my $startDeployTime = shift || &usage;

my @schedule = NFSol::generateDeploySchedule($startDeployTime);

while (@schedule) {
  my $region = shift @schedule;
  my $time   = shift @schedule;
  printf "%7s: %s\n", $region, displayTime($time);
}

sub usage {
  print "Usage: deployStrategy.pl <startDeployTime>\n";
  exit 1;
}

