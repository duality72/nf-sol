package NFSol::Region;
use NFSol::Functions qw/timeparse nextHourAfterTime/;
use Moose;

use constant DRIFT_THRESHOLD => 5;

has 'name'          => (is  => 'rw', isa => 'Str', required => 1);
has 'peakStartHour' => (is  => 'rw', isa => 'Int', required => 1);
has 'peakEndHour'   => (is  => 'rw', isa => 'Int', required => 1);
has 'buildId'       => (is  => 'rw', isa => 'Int', required => 1);

# Indicates if the given time is deployable, i.e. outside of peak hours
sub canDeployAt {
  my $self = shift;
  my $deployTime = timeparse(shift);
  my $nextPeakStart = nextHourAfterTime($self->peakStartHour, $deployTime);
  my $nextPeakEnd = nextHourAfterTime($self->peakEndHour, $deployTime);
  return($nextPeakStart < $nextPeakEnd);
}

# Return the number of builds between the currently deployed build ID and a given ID
# If the build ID is less than the deployed ID, drift is 0
# If the drift value is than the drift threshold, drift is 0
sub drift {
  my $self = shift;
  my $buildId = shift;
  my $drift = $buildId - $self->buildId;
  return ($drift <= DRIFT_THRESHOLD ? 0 : $drift);
}

1;

