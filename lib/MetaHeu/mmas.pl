#!bin/perl

use strict;
use warnings;

use Data::Dumper;
use Time::HiRes qw( time );

use lib '.';
use Mmas::InputData;
use Mmas::MainAlgo;
use Mmas::IsValid;

# time execution
my $start = time();

#MMAS main algo
# init data
my $planning_id = $ARGV[0];

my $config = Mmas::InputData->input_data($planning_id);
my $inital_config = $config;


#call main algo
my $params = {nb_iteration => 20,
	      nb_fourmis => 10,
	      t_max => 3,
	      t_min => 0.3,
	      ro => 0.3,
	      update_phero => 1,
	      alpha => 1,
	      beta => 1
};

my $res = Mmas::MainAlgo->run($params, $config);

$res->print();

=head
for my $sol (values(%{ $res->{9} })){
    print Mmas::IsValid->is_valid_solution($sol, $inital_config);
    print "\n";
    print Dumper $sol;
}
=cut

my $end = time();

printf("Execution Time: %0.02f s\n", $end - $start);
