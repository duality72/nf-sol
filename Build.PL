use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'NFSol',
    license             => 'perl',
    dist_author         => 'Chris Hilton <chris@dctank.com',
    dist_abstract       => 'NF solution',
    build_requires => {
        'Test::More'      => '0.98',
        'Test::Exception' => '0.31',
    },
    requires => {
        'Moose'           => '2.0604',
        'Time::ParseDate' => '2013.0912',
        'Date::Format'    => '2.24',
    },
);

$builder->create_build_script();

