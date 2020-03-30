#!bin/perl

use strict;
use warnings;

use Data::Dumper;
use lib '.';
use Object::Solution;

use Mmas::SelectUser;

#my $solution = Object::Solution->new();

#$solution->add(12, 6);
#$solution->add(11, 1);
#$solution->add(12, 1);

#print Dumper $solution->get_users(13);

#print Mmas::SelectUser->heuristique();

my $prob = {1 => 0.1,
	    2 => 0.2,
	    3 => 0.3,
	    4 => 0.005,
	    5 => 0.025,
	    6 => 0.17,
	    7 => 0.2
};
my $res = {1 => 0,
	   2 => 0,
	   3 => 0,
	   4 => 0,
	   5 => 0,
	   6 => 0,
	   7 => 0,
	   10 => 0
};
my @id;
for (my $i=0; $i < 1000; $i++){
    @id = Mmas::SelectUser->tirage($prob);
    $res->{$id[0]} += 1;
    if ( $id[0] == 10) {print Dumper($id[1])."::".Dumper($id[2]);}
#    print $id."\n";
}

print "res". Dumper $res->{10};				  
