package Mmas::MainAlgo;
use strict;
use warnings;
#use diagnostics;

use lib '../Metaheu';

use DateTime;
use Data::Dumper;

use Object::Solution;
use Mmas::Pheromone;
use Mmas::SelectUser;

sub run {
    my $self = shift;
    my ($params, $config) = @_;
    my $solution_global_best = Object::Solution->new();
    my $pheromone = Mmas::Pheromone->new({n_col => $config->{creneaux}->{nb_creneaux},
					  n_row => $config->{users}->{nb_users}
					 });
    $pheromone->initialize($config, $params->{t_max});

    # test for all random solutions
    my $temp;

    # while nb expérience or delais is over
    for (my $it=0; $it< $params->{nb_iteration}; $it++){
	my $solution_it_best = Object::Solution->new();
	
	# for each fourmis
	for (my $ant=0; $ant < $params->{nb_fourmis}; $ant++){
	    my $solution = Object::Solution->new();
	    
	    # for each creneau
	    for my $creneau_id ($config->{creneaux}->ordened_id()){
		my $creneau = $config->{creneaux}->get_creneau($creneau_id);
		
		# for each personnes required in creneau
		for (my $slot=0; $slot < $creneau->get_nb_personnes(); $slot++){

		    # Affect User with proba P(ti, e)(T(Ai-1),N(Ai-1))
		    $self->affect_user($solution, $config, $creneau, $pheromone, $params);
		    
		}#end for each personnes
		
	    }#end for each creneau

	    # Chose best solution between $solution and $solution_it_best
	    $solution_it_best = $self->cmp_solution($solution_it_best, $solution);

	    # temp test
	    $temp->{$it}->{$ant} = $solution;
	    
	}#end $nb_fourmis
	
	# Chosee best solution between $solution_it_best and $solution_global_best
	$solution_global_best = $self->cmp_solution($solution_global_best, $solution_it_best);

	# Update pheromone with the best solution
	$self->update_pheromone($pheromone, $solution_global_best);
	
    }#end $nb_iterations

    return $temp;
}

sub affect_user ($$$$$) {
    my $self = shift;
    my ($solution, $config, $creneau, $pheromone, $params) = @_;
    my $user_id = Mmas::SelectUser->select_user($solution, $config, $creneau, $pheromone, $params);

    $solution->add($creneau->get_creneau_id, $user_id);
    $self->update_config($config, $solution);
}

sub update_config {
    my $self = shift;
}

sub cmp_solution{
    my $self = shift;

}

sub update_pheromone{
    my $self = shift;

}
1;
