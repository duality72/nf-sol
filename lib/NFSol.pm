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
    buildId       => 10,
  ),
  'US-East' => new NFSol::Region(
    name          => 'US-East',
    peakStartHour => 5,
    peakEndHour   => 20,
    buildId       => 20,
  ),
  'EU' => new NFSol::Region(
    name          => 'EU',
    peakStartHour => 0,
    peakEndHour   => 15,
    buildId       => 30,
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
# Can also specify a wait time in number of hours between deployments (default 1)
sub generateDeploySchedule {
  my $time = timeparse(shift) or die "No deploy start time given"; 
  my $waitTime = shift || 1;
  my @schedule;
  my %regionsToDeploy = map {$_ => 1} @REGIONS;
  while (keys %regionsToDeploy) {
    foreach my $region (keys %regionsToDeploy) {
      if ($REGIONS{$region}->canDeployAt($time)) {
        push(@schedule, $region, $time);
        delete $regionsToDeploy{$region};
        # Move ahead the wait time minus one hour for the additional hour that will be added below
        $time += ONE_HOUR * ($waitTime - 1);
        last;
      }
    }
    $time += ONE_HOUR;
  }
  return @schedule;
}

# Return the amount of drift for a region from the given build ID
sub regionDrift {
  my $region = shift;
  my $buildId = shift;
  return $REGIONS{$region}->drift($buildId);
}

1;

