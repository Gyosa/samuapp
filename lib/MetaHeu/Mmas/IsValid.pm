package Mmas::IsValid;
use strict;
use warnings;
#use diagnostics;

use lib '../Metaheu';

use Data::Dumper;

sub is_valid_config {
    my $self = shift;
    # potentiel bug like Mmas::SlectUser->tirage #J'ai compris scalar<-array soit la taille du scalaire soit 1
    my $config = @_;

    ## il faut plus de souhait que de créneaux
    ## -> n'est pas une garantie de sortir une config valable
    
}

sub is_valid_solution {
    my $self = shift;
    my ($solution, $config) = @_;

    if ($self->all_creneaux_allocated($solution, $config)) {
	if ($self->user_twice_allocated($solution, $config)) {
	    if ($self->user_over_allocated($solution, $config)) {
		return 1;
	    }
	    return 13;
	}
	return 12;
    }
    return 11;
    #return 0;
    
}

sub all_creneaux_allocated {
    my $self = shift;
    my ($solution, $config) = @_;

    my $config_list_creneaux = $config->get_creneaux();

    for my $creneau ( $config_list_creneaux->get_creneaux() ) {

	my $nb_personnes = $creneau->get_nb_personnes();
	# implicite opération scalar with returning a array
	my $nb_affect = $solution->get_users($creneau->get_creneau_id());
	
	if ( $nb_personnes != $nb_affect ){
	    return 0;
	}
    }

    return 1;
}

sub user_twice_allocated {
    my $self = shift;
    my ($solution, $config) = @_;

    for my $creneau_id ( $solution->get_creneaux() ){
	my $creneau = $config->get_creneaux()->get_creneau($creneau_id);
	    
	my @users_id = $solution->get_users($creneau->get_creneau_id());

	my %seen = ();
	foreach my $id (@users_id){
	    next unless $seen{$id}++;
	    return 0;
	    
	}
    }
    return 1;
    
}

sub user_over_allocated {
    my $self = shift;
    my ($solution, $config) = @_;

    my @users = $config->get_users()->get_users();

    for my $user (@users){
	my $shouait = $user->get_souhait_jour() + $user->get_souhait_nuit();
	my $real_creneau = 0;
	
	for my $creneau_id ($solution->get_creneaux()){
	    my $creneau = $config->get_creneaux()->get_creneau($creneau_id);
	    
	    my %hash = map {$_ => 1} $solution->get_users($creneau->get_creneau_id());
	    $real_creneau += ( exists( $hash{$user->get_user_id()} ) ); 
	    
	}

	if ( $real_creneau > $shouait ) {
	    return 0;
	}
    }
    return 1;
}

sub user_hollyday_allocated {
    my $self = shift;
    my ($solution, $config) = @_;

    return 1;
}

1;
