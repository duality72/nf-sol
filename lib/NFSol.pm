use strict;
use warnings;
use Time::ParseDate;
use Time::Local;

package NFSol;

$NFSol::VERSION = '0.1';

$ENV{TZ} = "America/Los_Angeles";

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

