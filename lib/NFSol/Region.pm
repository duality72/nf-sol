package NFSol::Region;
use Moose;
use Time::ParseDate;
use Time::Local;

$ENV{TZ} = "America/Los_Angeles";

has 'name'          => (is  => 'rw', isa => 'Str');
has 'peakStartHour' => (is  => 'rw', isa => 'Int');
has 'peakEndHour'   => (is  => 'rw', isa => 'Int');

sub canDeploy {
  my $self = shift;
  my $deployTime = shift;
  my $nextPeakStart = nextHourAfterTime($self->peakStartHour, $deployTime);
  my $nextPeakEnd = nextHourAfterTime($self->peakEndHour, $deployTime);
  return($nextPeakStart < $nextPeakEnd);
}

sub nextHourAfterTime {
  my $hour = shift;
  my $time = timeparse(shift);
  my @time = gmtime($time);
  # If the hour has already passed, go to the next day
  if ($time[2] >= $hour) { @time = gmtime($time + 86400); }
  @time[0,1,2] = (0,0,$hour);
  return Time::Local::timegm(@time[0..5]);
}

sub timeparse {
  my $text = shift;
  my($time, $error) = Time::ParseDate::parsedate($text);
  die "Could not parse '$text': $error" unless defined $time;
  return $time;
}

1;

