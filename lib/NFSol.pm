package NFSol;

use strict;
use warnings;
use NFSol::Region;
use NFSol::Functions qw/timeparse ONE_HOUR/;

$NFSol::VERSION = '0.1';

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

# From the regions given, determine which regions can deploy at the given time
sub regionsCanDeploy {
  my $time = shift or die "No deploy time provided";
  my @regions = @_ or die "No regions provided";
  my @deployableRegions;
  foreach my $region (@regions) {
    die "Region $region does not exist" unless $REGIONS{$region};
    push(@deployableRegions, $region) if $REGIONS{$region}->canDeployAt($time);
  }
  return @deployableRegions;
}

# Return a list of regions and deployTimes that can be used as a deployment schedule
# Results alternate between region and deploy time
sub generateDeploySchedule {
  my $time = timeparse(shift) or die "No deploy start time given"; 
  my @schedule;
  my %regionsToDeploy = map {$_ => 1} @REGIONS;
  while (keys %regionsToDeploy) {
    foreach my $region (keys %regionsToDeploy) {
      if ($REGIONS{$region}->canDeployAt($time)) {
        push(@schedule, $region, $time);
        delete $regionsToDeploy{$region};
        last;
      }
    }
    $time += ONE_HOUR;
  }
  return @schedule;
}

1;

