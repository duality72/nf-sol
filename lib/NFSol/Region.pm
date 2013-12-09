package NFSol::Region;
use NFSol::Functions qw/timeparse nextHourAfterTime/;
use Moose;

has 'name'          => (is  => 'rw', isa => 'Str');
has 'peakStartHour' => (is  => 'rw', isa => 'Int');
has 'peakEndHour'   => (is  => 'rw', isa => 'Int');

# Indicates if the given time is deployable, i.e. outside of peak hours
sub canDeployAt {
  my $self = shift;
  my $deployTime = timeparse(shift);
  my $nextPeakStart = nextHourAfterTime($self->peakStartHour, $deployTime);
  my $nextPeakEnd = nextHourAfterTime($self->peakEndHour, $deployTime);
  return($nextPeakStart < $nextPeakEnd);
}

1;

