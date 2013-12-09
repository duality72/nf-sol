use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol') };

# Verify module can be included via "require" pragma
require_ok( 'NFSol' );

# @REGIONS and %REGIONS
# Test that there are three regions defined
is(scalar @NFSol::REGIONS, 3, "Three regions defined in array");
foreach my $region (@NFSol::REGIONS) {
  isa_ok($NFSol::REGIONS{$region}, 'NFSol::Region', "Region $region defined");
}

