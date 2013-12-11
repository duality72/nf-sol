#!/usr/bin/perl

use strict;
use warnings;
use lib 'lib';
use Getopt::Long;
use NFSol;
use NFSol::Functions qw/displayTime/;

my $startTime = 'now';
my $waitTime = 1;
my $buildId = 0;
my $help;
GetOptions(
  "startTime=s" => \$startTime,
  "waitTime=i"  => \$waitTime,
  "buildId=i"   => \$buildId,
  "help|?"      => \$help,
) or &usage;
&usage if $help or @ARGV;

my @schedule = NFSol::generateDeploySchedule($startTime, $waitTime);

while (@schedule) {
  my $region   = shift @schedule;
  my $time     = shift @schedule;
  my $drift    = NFSol::regionDrift($region, $buildId);
  my $driftStr = $drift ? " Drift: $drift" : '';
  printf "%7s: %s%s\n", $region, displayTime($time), $driftStr;
}

sub usage {
  print <<END;
Usage: deployStrategy.pl [--startTime <time>] [--waitTime #] [--buildId #]

  startTime - The earliest time a deployment can start.
              Ex. '12/08/13 07:00:00' or '3pm tomorrow'.
              Defaults to 'now' and parsing in PST.
  waitTime  - Time to wait between deployments in hours.
              Defaults to 1.
  buildId   - The build ID that will be deployed.
              Used to report on drift of already deployed builds.
              Defaults to 0 (no report)
END
  exit 1;
}

