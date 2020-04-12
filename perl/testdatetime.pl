#!/usr/bin/perl
use strict;
use DateTime;
use Data::Dumper;
my $d1 = DateTime->new(year => 2020, month => 4, day => 11, hour => 18,);
my $d2 = DateTime->new(year => 2020, month => 5, day => 1, hour=> 4,);
my $res = $d1->delta_ms($d2);
print Dumper $res;
