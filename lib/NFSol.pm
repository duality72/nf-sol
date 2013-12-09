use strict;
use warnings;
use Time::ParseDate;
use Time::Local;
use NFSol::Region;

package NFSol;

$NFSol::VERSION = '0.1';

$ENV{TZ} = "America/Los_Angeles";

# TODO: Account for DST for US-West and East
our %REGIONS = (
  'US-West' => new NFSol::Region(
    name          => 'US-West',
    peakStartHour => 8,
    peakEndHour   => 23,
  ),
  'US-East' => new NFSol::Region(
    name          => 'US-East',
    peakStartHour => 5,
    peakEndHour   => 20,
  ),
  'EU' => new NFSol::Region(
    name          => 'EU',
    peakStartHour => 0,
    peakEndHour   => 15,
  ),
);
our @REGIONS = keys %REGIONS;

sub regionsCanDeploy {
  my $time = shift or die "No deploy time provided";
  my @regions = @_ or die "No regions provided";
  my @deployableRegions;
  foreach my $region (@regions) {
    die "Region $region does not exist" unless $REGIONS{$region};
    push(@deployableRegions, $region) if $REGIONS{$region}->canDeploy($time);
  }
  return @deployableRegions;
}

1;

