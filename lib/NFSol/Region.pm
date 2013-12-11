package NFSol::Region;
use NFSol::Functions qw/timeparse nextHourAfterTime/;
use Moose;

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

1;

