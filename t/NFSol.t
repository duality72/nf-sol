use strict;
use warnings;
use Test::More qw(no_plan);

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol') };

# Verify module can be included via "require" pragma
require_ok( 'NFSol' );

# Test 
my $testCall1 = NFSol::test();
is($testCall1, 1, "test IS 1");

