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
  buildId       => 6,
]);

# canDeployAt
# Cannot deploy at noon today 
my $testCanDeployCall1 = $region->canDeployAt("noon today GMT");
ok(!$testCanDeployCall1, "Cannot deploy at noon today");

# Can deploy at 4pm today 
my $testCanDeployCall2 = $region->canDeployAt("4pm today GMT");
ok($testCanDeployCall2, "Can deploy at 4pm today");

# Cannot deploy at midnight today 
my $testCanDeployCall3 = $region->canDeployAt("midnight today GMT");
ok(!$testCanDeployCall3, "Cannot deploy at midnight today");

# Can deploy at 3pm today 
my $testCanDeployCall4 = $region->canDeployAt("3pm today GMT");
ok($testCanDeployCall4, "Can deploy at 3pm today");

