use strict;
use warnings;

use Test::More;
use Test::CleanNamespaces;

# this test won't pass with older MooseX::Types!
use Test::Requires { 'MooseX::Types' => '0.42' };
all_namespaces_clean();

done_testing;
