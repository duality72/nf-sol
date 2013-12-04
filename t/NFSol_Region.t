use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol::Region') };

# Verify module can be included via "require" pragma
require_ok( 'NFSol::Region' );

my $region = new_ok('NFSol::Region');

# timeparse
# Can parse 1/1/1970 12am GMT
my $testTimeparseCall1 = NFSol::Region::timeparse("1/1/1970 12am GMT");
is($testTimeparseCall1, 0, "Can parse '1/1/1970 12am GMT'");

# Can parse today 16:00
my $testTimeparseCall2 = NFSol::Region::timeparse("today 16:00");
ok($testTimeparseCall2 > 1385962762, "Can parse 'today 16:00'");

# Cannot parse garbage
dies_ok(sub { NFSol::Region::timeparse("garbage") }, "Cannot parse garbage");

# Test when the next given hour occurs after a given time
# Next hour 0 after epoch
my $testNextHourCall1 = NFSol::Region::nextHourAfterTime(0, "1/1/1970 12am GMT");
is($testNextHourCall1, 86400, "Next hour 0 after epoch");

# Next hour 1 after epoch
my $testNextHourCall2 = NFSol::Region::nextHourAfterTime(1, "1/1/1970 12am GMT");
is($testNextHourCall2, 3600, "Next hour 1 after epoch");


