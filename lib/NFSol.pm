use strict;
use warnings;
use Time::ParseDate;
use Time::Local;
use NFSol::Region;

package NFSol;

$NFSol::VERSION = '0.1';

$ENV{TZ} = "America/Los_Angeles";

our @REGIONS = ('US-West', 'US-East', 'EU');
# TODO: Account for DST for US-West and East
our %REGIONS = (
  'US-West' => new NFSol::Region(
    name          => 'US-West',
    peakStartHour => 16,
    peakEndHour   => 7,
  ),
  'US-East' => new NFSol::Region(
    name          => 'US-East',
    peakStartHour => 19,
    peakEndHour   => 10,
  ),
  'EU' => new NFSol::Region(
    name          => 'EU',
    peakStartHour => 0,
    peakEndHour   => 15,
  ),
);

1;

