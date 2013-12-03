use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol') };

# Verify module can be included via "require" pragma
require_ok( 'NFSol' );

# timeparse
# Can parse 1/1/1970 12am GMT
my $testTimeparseCall1 = NFSol::timeparse("1/1/1970 12am GMT");
is($testTimeparseCall1, 0, "Can parse '1/1/1970 12am GMT'");

# Can parse today 16:00
my $testTimeparseCall2 = NFSol::timeparse("today 16:00");
ok($testTimeparseCall2 > 1385962762, "Can parse 'today 16:00'");

# Cannot parse garbage
dies_ok(sub { NFSol::timeparse("garbage") }, "Cannot parse garbage");

# Test when the next given hour occurs after a given time
# Next hour 0 after epoch
my $testNextHourCall1 = NFSol::nextHourAfterTime(0, "1/1/1970 12am GMT");
is($testNextHourCall1, 86400, "Next hour 0 after epoch");

# Next hour 1 after epoch
my $testNextHourCall2 = NFSol::nextHourAfterTime(1, "1/1/1970 12am GMT");
is($testNextHourCall2, 3600, "Next hour 1 after epoch");

