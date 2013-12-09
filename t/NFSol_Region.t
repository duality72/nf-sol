use strict;
use warnings;
use Test::More qw(no_plan);

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol::Region') };

# Verify module can be included via "require" pragma
require_ok( 'NFSol::Region' );

my $region = new_ok('NFSol::Region', [
  name          => 'EU',
  peakStartHour => 0,
  peakEndHour   => 15,
]);

# canDeploy
# Cannot deploy at noon today 
my $testCanDeployCall1 = $region->canDeploy("noon today GMT");
ok(!$testCanDeployCall1, "Cannot deploy at noon today");

# Can deploy at 4pm today 
my $testCanDeployCall2 = $region->canDeploy("4pm today GMT");
ok($testCanDeployCall2, "Can deploy at 4pm today");

