package Mmas::FctObj;
use strict;
use warnings;
#use diagnostics;

use lib '../Metaheu';

use Data::Dumper;

sub fct_obj {
    my $self = shift;
    my ($config, $solution) = @_;

    my $glob_variance = $self->variance_creneaux($config, $solution);
    return $glob_variance;   

}

sub variance_creneaux {
    my $self = shift;
    my ($config, $sol) = @_;

    my $start_date = $config->get_start_date();
    my $end_date = $config->get_end_date();

    my $glob_variance = 0;
    #for each user
    for my $user ( $config->get_users()->get_users() ) {
	#nombre de créneaux fait par user
	my $nb_cren = $sol->nb_cren_user( $user->get_user_id() );
	#espacement opti en heure pour les crénaux du planning
	my $delta = $start_date->delta_ms($end_date);
	my $moy = $delta->{minutes}/($nb_cren + 1);

	# get list of all durations between
	my @list_cren_id = $sol->cren_user( $user->get_user_id() );
	my @delta_list_cren;

	for (my $i=0; $i < scalar(@list_cren_id); $i++) {
	    my ($dt_1, $dt_2);
	    if ($i == 0){
		$dt_1 = $start_date;
		$dt_2 = $config->get_creneau($list_cren_id[$i])->get_start_datetime();
	    }elsif ($i == scalar(@list_cren_id)){
		$dt_1 =$config->get_creneau($list_cren_id[$i-1])->get_start_datetime();
		$dt_2 = $end_date;
	    }else{
		$dt_1 = $config->get_creneau($list_cren_id[$i-1])->get_start_datetime();
		$dt_2 = $config->get_creneau($list_cren_id[$i])->get_start_datetime();
	    }
		
	    my $delta = $dt_1->delta_ms($dt_2);
	    push(@delta_list_cren, $delta->{minutes});
	}
	
	# calcul de la variance
	my $variance = $self->calc_variance($moy, \@delta_list_cren);
	$glob_variance += $variance;;
    }
    return $glob_variance; 
}

sub calc_variance {
    my $self = shift;
    my ($moy, $values) = @_;
    my @values = @$values;

    my $sum = 0;
    for my $val ( @values ){
	$sum += $val**2;
    }

    if (scalar(@values) == 0){ return 0; }
    my $variance = $sum / scalar(@values) - $moy**2;
    return $variance;
}


1;
