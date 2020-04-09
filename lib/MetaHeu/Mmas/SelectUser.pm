package Mmas::SelectUser;

use strict;
use warnings;
#use diagnostics;

use lib '../Metaheu';

use Data::Dumper;

sub select_user ($$$$) {
    my $self = shift;
    my ($solution, $config, $creneau, $pheromone, $params) = @_;

    # calculation of probabilities for each user
    my $probas = {};
    for my $user ( $config->get_users()->get_users() ) {

	my $prob = $self->calc_prob($solution, $config, $creneau, $user, $pheromone, $params);

	# set proba per user
	$probas->{$user->get_user_id()} = $prob;
    }

    # tirage a user with probabilities
    my $select_user_id = $self->tirage($probas);
    return $select_user_id;
}

# return hash with probalities of each users
### calc probas for everyone just one time and after make all probas in once
sub calc_prob {
    my $self = shift;
    my ($solution, $config, $creneau, $user, $pheromone, $params) = @_;
    #problème de correspondance entre la matrix et les id 
    my $t_val = $pheromone->get_val($creneau->get_creneau_id(), $user->get_user_id());
    my $h_val = $self->heuristique($solution, $config, $creneau, $user);
    
    my $sum;
    for my $u ( $config->get_users()->get_users() ) {
	my $user_t_val = $pheromone->get_val($creneau->get_creneau_id(), $u->get_user_id());
	my $user_h_val = $self->heuristique($solution, $config, $creneau, $u);
	my $val = $user_t_val**$params->{alpha} * $user_h_val**$params->{beta};
	$sum += $val;
    }

    my $prob = ( $t_val**$params->{alpha} * $h_val**$params->{beta} ) / $sum ;
    return $prob;
}

sub heuristique {
    my $self = shift;
    my ($solution, $config, $creneau, $user) = @_;

    #test if user can make a creneau
    my $creneau_available = $user->get_souhait_jour + $user->get_souhait_nuit;
    if ($creneau_available == 0){
	return 0;
    }

    #test if is already on this creneau
    ## test if a user are arlready placed on this creneaux
    my @users = $solution->get_users($creneau->get_creneau_id());
    if ( scalar(@users) > 0){
	#user is the same that tested user
	my $user_id = $user->get_user_id();
	if ( grep ( /^$user_id$/, @users ) ){
	    return 0;
	}
    }
    return 1;

    #test if is vacances 
}

sub tirage ($) {
    my $self = shift;
    my $probas = shift @_;
    my $eps = 100000;
    my $r = int(rand($eps+1))/$eps;
    my $prob = 0;
    # test if probas sum make 1 else p(-1) not null
    foreach my $user_id (keys(%{ $probas })){
	$prob +=  $probas->{$user_id};
	# second testing case is for match when $r == 1 : <= doesn't match
	if ( $r <= $prob || $r eq $prob ) {
	    return $user_id;
	}
    }
    return -1;
}

1;
