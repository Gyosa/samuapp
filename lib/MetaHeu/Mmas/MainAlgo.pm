package Mmas::MainAlgo;
use strict;
use warnings;
#use diagnostics;

use lib '../Metaheu';

use DateTime;
use Data::Dumper;
use Storable qw(dclone);

use Object::Solution;
use Mmas::Pheromone;
use Mmas::SelectUser;
use Mmas::FctObj;

sub run {
    my $self = shift;
    my ($params, $init_config) = @_;
    my $solution_global_best = Object::Solution->new();
    my $pheromone = Mmas::Pheromone->new({n_col => $init_config->{creneaux}->{nb_creneaux},
					  n_row => $init_config->{users}->{nb_users}
					 });
    $pheromone->initialize($init_config, $params->{t_max});

    # test for all random solutions
    my $temp;

    # while nb expérience or delais is over
    for (my $it=0; $it< $params->{nb_iteration}; $it++){
	print "Main Itération N°".$it."\n";
	my $solution_it_best = Object::Solution->new();
	
	# for each fourmis
	for (my $ant=0; $ant < $params->{nb_fourmis}; $ant++){
	    print "Fourmis N°".$ant."\n";
	    my $solution = Object::Solution->new();
	    my $config = dclone($init_config);
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
	    print "Itération cmp/";
	    $solution_it_best = $self->cmp_solution($init_config, $solution_it_best, $solution);

	    # temp test
	    $temp->{$it}->{$ant} = $solution;
	    
	}#end $nb_fourmis
	
	# Chosee best solution between $solution_it_best and $solution_global_best
	print "Global cmp/";
	$solution_global_best = $self->cmp_solution($init_config, $solution_global_best, $solution_it_best);

	# Update pheromone with the best solution
	$self->update_pheromone($params, $init_config, $pheromone, $solution_global_best);
	$pheromone->print($solution_global_best);
	
    }#end $nb_iterations

    return $solution_global_best;
}

sub affect_user ($$$$$) {
    my $self = shift;
    my ($solution, $config, $creneau, $pheromone, $params) = @_;
    my $user_id = Mmas::SelectUser->select_user($solution, $config, $creneau, $pheromone, $params);
    #print "user_id selected : $user_id";print "\n";
    
    my $user = $config->get_users->get_user($user_id);
    $solution->add($creneau->get_creneau_id, $user->get_user_id());
    $self->update_config($config, $solution, $creneau, $user);
}

sub update_config {
    my $self = shift;
    my ($config, $solution, $creneau, $user) = @_;
    # select $creneau type

    # delete for this user this type of creneau

    # hardcode with day creneaux
    $user->set_souhait_jour($user->get_souhait_jour() - 1);
    my $user_id = $user->get_user_id();
    
}

sub cmp_solution{
    my $self = shift;
    my ($config, $sol_1, $sol_2) = @_;


    my $res_sol_1 = Mmas::FctObj->fct_obj($config, $sol_1);
    my $res_sol_2 = Mmas::FctObj->fct_obj($config, $sol_2);

    # compare and return best solution
    if ( $res_sol_2 < $res_sol_1 || $res_sol_1 == 0){
	print "sol2 chose -> ".$res_sol_2."\n";
	return $sol_2;
    }else{
	print "sol1 chose -> ".$res_sol_1."\n";
	return $sol_1;
    }
    
}

sub update_pheromone{
    my $self = shift;
    my ($params, $config, $pheromone, $sol) = @_;

    # loop over pheromone matrix
    # $col -> timeslot & $row -> user
    for my $cren ( $config->get_creneaux()->get_creneaux() ){
	my $cren_id = $cren->get_creneau_id();
	for my $user ( $config->get_users()->get_users() ){
	    my $user_id = $user->get_user_id();
	    my $t_val = $pheromone->get_val($cren_id, $user_id);
	    # test print 
	    #my $fmt = 'Select User:$%2d Users in creneaux:'.' $%2d' x scalar($sol->get_users($cren_id));
	    #printf($fmt."\n", $user_id, $sol->get_users($cren_id));
	    #end test
	    
	    # test if user is chose for this creneaux
	    if ( grep(/^$user_id$/ , $sol->get_users($cren_id)) ){
		$t_val = (1 - $params->{ro}) * $t_val + $params->{update_phero};
	    }else{
		$t_val = (1 - $params->{ro}) * $t_val;
	    }

	    # test if t_val are in [Tmin,Tmax]
	    if ($t_val > $params->{t_max} ){
		$t_val = $params->{t_max};
	    }if ($t_val < $params->{t_min} ){
		$t_val = $params->{t_min};
	    }

	    # affect new value of t_val in matrix
	    $pheromone->set_val($cren_id, $user_id, $t_val);
	    
	}
    }

}
1;
