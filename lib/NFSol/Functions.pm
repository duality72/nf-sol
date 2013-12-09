package NFSol::Functions;
use Time::ParseDate;
use Time::Local;
use Date::Format;

our (@ISA, @EXPORT_OK);
BEGIN {
  require Exporter;
  @ISA = qw(Exporter);
  @EXPORT_OK = qw/ONE_HOUR ONE_DAY nextHourAfterTime timeparse displayTime/;
}

use constant ONE_HOUR => 60 * 60;       # seconds in minute * minutes in hour
use constant ONE_DAY  => ONE_HOUR * 24; # seconds in hour * hours in day

# By default, times will be parsed relative to US-West
$ENV{TZ} = "America/Los_Angeles";
# All time calculations, though, are done in GMT

# Find the next epoch time a certain hour occurs after a given time
sub nextHourAfterTime {
  my $hour = shift;
  my $time = timeparse(shift);
  my @time = gmtime($time);
  # If the hour has already passed, go to the next day
  if ($time[2] >= $hour) { @time = gmtime($time + ONE_DAY); }
  @time[0,1,2] = (0,0,$hour);
  return Time::Local::timegm(@time[0..5]);
}

# Parse text into epoch time
sub timeparse {
  my $text = shift;
  # If the text is already all digits, assume it is already an epoch time and return it
  return $text unless $text =~ /\D/;
  my($time, $error) = Time::ParseDate::parsedate($text);
  die "Could not parse '$text': $error" unless defined $time;
  return $time;
}

# Transform a time to a display string
sub displayTime {
  my $time = shift;
  my $uswestTime = time2str("%c %Z", $time, "PST");
  my $useastTime = time2str("%c %Z", $time, "EST");
  my $euTime     = time2str("%c %Z", $time, "GMT");
  return sprintf "%s   %s   %s", $uswestTime, $useastTime, $euTime;
}

1;

