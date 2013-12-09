use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;

use constant NUM_REGIONS => 3;

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol') };

# Verify module can be included via "require" pragma
require_ok( 'NFSol' );

# @REGIONS and %REGIONS
# Test that there are three regions defined
is(scalar @NFSol::REGIONS, NUM_REGIONS, "Three regions defined in array");
foreach my $region (@NFSol::REGIONS) {
  isa_ok($NFSol::REGIONS{$region}, 'NFSol::Region', "Region $region defined");
}

# regionsCanDeploy
# Test that no regions can deploy at noon GMT
my @testRegionsCanDeployCall1 = NFSol::regionsCanDeploy("noon today GMT", @NFSol::REGIONS);
is(scalar @testRegionsCanDeployCall1, 0, "No regions can deploy at noon GMT");

# Test that all regions can deploy at 23:30 GMT
my @testRegionsCanDeployCall2 = NFSol::regionsCanDeploy("23:30 today GMT", @NFSol::REGIONS);
is_deeply(\@testRegionsCanDeployCall2, \@NFSol::REGIONS, "All regions can deploy at noon GMT");

# Test that US regions can deploy at midnight GMT
my @testRegionsCanDeployCall3 = NFSol::regionsCanDeploy("midnight today GMT", @NFSol::REGIONS);
is_deeply(\{map {$_ => 1} @testRegionsCanDeployCall3}, \{'US-West' => 1, 'US-East' => 1}, "US regions can deploy at midnight GMT");

