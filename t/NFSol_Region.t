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
  buildId       => 30,
]);

# canDeployAt
# Cannot deploy at noon today 
my $testCanDeployAtCall1 = $region->canDeployAt("noon today GMT");
ok(!$testCanDeployAtCall1, "Cannot deploy at noon today");

# Can deploy at 4pm today 
my $testCanDeployAtCall2 = $region->canDeployAt("4pm today GMT");
ok($testCanDeployAtCall2, "Can deploy at 4pm today");

# Cannot deploy at midnight today 
my $testCanDeployAtCall3 = $region->canDeployAt("midnight today GMT");
ok(!$testCanDeployAtCall3, "Cannot deploy at midnight today");

# Can deploy at 3pm today 
my $testCanDeployAtCall4 = $region->canDeployAt("3pm today GMT");
ok($testCanDeployAtCall4, "Can deploy at 3pm today");

# drift
# Test that drift from build ID 30 is 0
my $testDriftCall1 = $region->drift(30);
is($testDriftCall1, 0, "Drift from build ID 30 is 0");

# Test that drift from build ID 40 is 10
my $testDriftCall2 = $region->drift(40);
is($testDriftCall2, 10, "Drift from build ID 40 is 10");

# Test that drift from build ID 10 is 0
my $testDriftCall3 = $region->drift(10);
is($testDriftCall3, 0, "Drift from build ID 10 is 0");

