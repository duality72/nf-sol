use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'NFSol',
    license             => 'perl',
    dist_author         => 'Chris Hilton <chris@dctank.com',
    dist_abstract       => 'NF solution',
    build_requires => {
        'Test::More' => '0.10',
    },
);

$builder->create_build_script();

