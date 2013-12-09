use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol::Functions', qw/timeparse nextHourAfterTime displayTime/) };

# Verify module can be included via "require" pragma
require_ok( 'NFSol::Functions' );

# timeparse
# Can parse 1/1/1970 12am GMT
my $testTimeparseCall1 = timeparse("1/1/1970 12am GMT");
is($testTimeparseCall1, 0, "Can parse '1/1/1970 12am GMT'");

# Can parse today 16:00
my $testTimeparseCall2 = timeparse("today 16:00");
ok($testTimeparseCall2 > 1385962762, "Can parse 'today 16:00'");

# Cannot parse garbage
dies_ok(sub { timeparse("garbage") }, "Cannot parse garbage");

# Test when the next given hour occurs after a given time
# Next hour 0 after epoch
my $testNextHourCall1 = nextHourAfterTime(0, "1/1/1970 12am GMT");
is($testNextHourCall1, 86400, "Next hour 0 after epoch");

# Next hour 1 after epoch
my $testNextHourCall2 = nextHourAfterTime(1, "1/1/1970 12am GMT");
is($testNextHourCall2, 3600, "Next hour 1 after epoch");

# displayTime
# Test display time for epoch in PST, EST, and GMT
my $testDisplayTimeCall1 = displayTime(0);
is($testDisplayTimeCall1, "12/31/69 16:00:00 PST   12/31/69 19:00:00 EST   01/01/70 00:00:00 GMT", "Display time for epoch in PST, EST, and GMT");

# Test display time for 1am after epoch in PST, EST, and GMT
my $testDisplayTimeCall2 = displayTime(3600);
is($testDisplayTimeCall2, "12/31/69 17:00:00 PST   12/31/69 20:00:00 EST   01/01/70 01:00:00 GMT", "Display time for epoch in PST, EST, and GMT");

