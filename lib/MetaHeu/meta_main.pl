#!/usr/bin/perl
#package MetaHeu;
use strict;
use warnings;

use Data::Dumper;
use lib '.';
use Algo::InputData;
use Algo::CreateSol;

## input data
# require './Algo/input_data.pl';
my $config = Algo::InputData->input_data() ; # (list creneaux, list user) config
#debug
my @results = @$config;
my $users = $results[0];
my @users = @$users;
my $creneaux = $results[1];
my @creneaux = @$creneaux;
#print Dumper $users[1];

## create_solution

my $solution = Algo::CreateSol->create_solution($config); # return une solution per config
print $solution;
## apply metaheu algo 

#my $solution_s = meta_algo(); # best solution

## output data

#require './Algo/output_data.pl';
	#my $res = output_data(); # print result
#print $res;

## objective funxtion

#my $obj_f = fonction_obj(); # return obj_j (double) per solution
