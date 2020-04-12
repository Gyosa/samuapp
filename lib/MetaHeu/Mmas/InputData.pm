package Mmas::InputData;
use strict;
use warnings;
#use diagnostics;

#BEGIN { push @INC,  '../../lib/' }
use lib '../../lib';
use lib '../Metaheu';

use SamuApp::Schema;
use DateTime;
use Data::Dumper;

use Object::ListUser;
use Object::User;

use Object::ListCreneau;
use Object::Creneau;

use Object::Config;

sub input_data ($){
    # require planning id
    my ($self, $planning_id) = @_;
    my $schema = SamuApp::Schema->connect('dbi:Pg:dbname=samuapp;host=localhost', 'catalyst', 'catalyst');

    my $planning = $schema->resultset('Planning')->find($planning_id);

    my $list_user = input_users($schema, $planning_id);

    my $list_creneau = input_creneau($schema, $planning_id);

    my $config = Object::Config->new({users => $list_user,
				      creneaux => $list_creneau,
				      start_date => $planning->planning_start_date,
				      end_date => $planning->planning_end_date
				     });

    return $config;
    
}
sub input_users{
    my ($schema, $planning_id) = @_;
    my $list_user = Object::ListUser->new();

    # génération des users	
    my @utilisateurs = $schema->resultset('Utilisateur')->all;
    
    for my $user (@utilisateurs){
	my $user_id = $user->utilisateur_id;

	#use find on dual primary key !
	my @infos = $schema->resultset('Infoplanning')->search({
	    infoplanning_utilisateur_id => $user_id,
	    infoplanning_planning_id => $planning_id});
	my $info = $infos[0];
	#return Dumper @infos;
	my $souhait_jour = $info->infoplanning_souhait_jour;
	my $souhait_nuit = $info->infoplanning_souhait_nuit;

	#creation d'un utilisateur
	my $user = Object::User->new({user_id => $user_id,
				      souhait_jour => $souhait_jour,
				      souhait_nuit => $souhait_nuit
				     });
	$list_user->add_user($user);
    }

    return $list_user;
}
sub input_creneau{
    my ($schema, $planning_id) = @_;
    my $list_creneau = Object::ListCreneau->new();

    #generation des creneaux	
    my $planning = $schema->resultset('Planning')->find($planning_id);
    my @creneaux = $planning->creneaus;
    for my $creneau (@creneaux) {
	
	my $year = $creneau->creneau_start_datetime->year;
	my $month = $creneau->creneau_start_datetime->month;
	my $day = $creneau->creneau_start_datetime->day;
	    
	my $start_datetime = DateTime->new({year =>$year,
					    month =>$month,
					    day =>$day
					   });

	$year = $creneau->creneau_end_datetime->year;
	$month = $creneau->creneau_end_datetime->month;
	$day = $creneau->creneau_end_datetime->day;
	
	my $end_datetime = DateTime->new({year => $year,
					    month => $month,
					    day => $day
					 });

	my $creneau_id = $creneau->creneau_id;
	my $nb_personnes = $creneau->creneau_nbpersonnes;
	# creation d'un creneau
	my $c = Object::Creneau->new({creneau_id => $creneau_id,
				      nb_personnes => $nb_personnes,
				      start_datetime => $start_datetime,
				      end_datetime => $end_datetime
				     });
	$list_creneau->add_creneau($c);
    }
    return $list_creneau;
}
1;

