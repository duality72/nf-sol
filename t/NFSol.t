use strict;
use warnings;
use Test::More qw(no_plan);
use Test::Exception;

# Verify module can be included via "use" pragma
BEGIN { use_ok('NFSol') };

# Verify module can be included via "require" pragma
require_ok( 'NFSol' );

