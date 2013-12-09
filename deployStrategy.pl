#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use NFSol;
use NFSol::Functions qw/displayTime/;

my $startDeployTime = shift || &usage;
my $waitTime = shift || 1;

my @schedule = NFSol::generateDeploySchedule($startDeployTime, $waitTime);

while (@schedule) {
  my $region = shift @schedule;
  my $time   = shift @schedule;
  printf "%7s: %s\n", $region, displayTime($time);
}

sub usage {
  print <<END;
Usage: deployStrategy.pl <startDeployTime> [waitTime]

  startDeployTime- ex. '12/08/13 07:00:00' or '3pm tomorrow'
  waitTime       - in hours
END
  exit 1;
}

