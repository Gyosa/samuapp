#!bin/perl

use strict;
use warnings;

use Data::Dumper;
use lib '.';
use Mmas::InputData;


#MMAS main algo
# init data
my $planning_id = ARGV[0];

my $config = Mmas::InputData->input_data($planning_id);
my $inital_config = $config;

#call main algo
my $params = {nb_fourmis => 10};

my $res = Mmas::MainAlgo->run($params, $config);


#print Dumper($list_user);

