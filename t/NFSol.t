use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;
use NFSol::Functions qw/ONE_HOUR/;

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

# generateDeploySchedule
# Test that starting a deploy at noon GMT goes EU, US-East, US-West
my @testGenerateDeployScheduleCall1 = NFSol::generateDeploySchedule("noon today GMT");
is($testGenerateDeployScheduleCall1[0], 'EU', "EU region first to deploy after noon GMT");
is($testGenerateDeployScheduleCall1[2], 'US-East', "US-East region second to deploy after noon GMT");
is($testGenerateDeployScheduleCall1[4], 'US-West', "US-West region third to deploy after noon GMT");
 
# Test that starting a deploy at midnight GMT has EU deploy last
my @testGenerateDeployScheduleCall2 = NFSol::generateDeploySchedule("midnight today GMT");
is($testGenerateDeployScheduleCall2[4], 'EU', "EU region last to deploy after midnight GMT");
 
# Test that starting a deploy with a 5 hour wait time goes EU, US-East, US-West with proper separation
my @testGenerateDeployScheduleCall3 = NFSol::generateDeploySchedule("noon today GMT", 5);
is($testGenerateDeployScheduleCall3[0], 'EU', "EU region first to deploy after noon GMT");
is($testGenerateDeployScheduleCall3[2], 'US-East', "US-East region second to deploy after noon GMT");
ok($testGenerateDeployScheduleCall3[3] - $testGenerateDeployScheduleCall3[1] == 5 * ONE_HOUR, "US-East region deploys five hours after EU");
is($testGenerateDeployScheduleCall3[4], 'US-West', "US-West region third to deploy after noon GMT");
ok($testGenerateDeployScheduleCall3[5] - $testGenerateDeployScheduleCall3[3] == 5 * ONE_HOUR, "US-West region deploys five hours after US-East");
 

