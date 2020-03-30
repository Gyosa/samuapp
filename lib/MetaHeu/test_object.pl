#!/usr/bin/perl
#package MetaHeu;
use strict;
use warnings;
#use diagnostics;

use Data::Dumper;
use lib '.';
#use Object;
use Object::User;
use Object::ListUser;
use Object::Creneau; 
use Object::ListCreneau;
use Object::Config;

use Mmas::Pheromone;

# init user
my $user1 = Object::User->new({user_id => 1,
					   souhait_jour => 7,
					   souhait_nuit => 12
					  });
my $user2 = Object::User->new({user_id => 2,
					   souhait_jour => 5,
					   souhait_nuit => 15
					  });

my $list_users = Object::ListUser->new ({nb_users => 3,
								users => [$user1, $user2]
							   });

$list_users->set_nb_users;
#print $list_users->get_nb_users;
#print $list_users->get_user(1)->get_souhait_jour();


my $creneau1 = Object::Creneau->new({creneau_id => 1,
							 nb_personnes => 2,
							 start_datetime => 23,
							 end_datetime => 24
							});
my $creneau2 = Object::Creneau->new({creneau_id => 2,
							 nb_personnes => 2,
							 start_datetime => 21,
							 end_datetime => 22
							});

my $list_creneaux = Object::ListCreneau->new({nb_creneaux => 3,
									  creneaux => [$creneau1, $creneau2]
									 });

$list_creneaux->set_nb_creneaux;
#print $list_creneaux->get_nb_creneaux;
#print $list_creneaux->get_creneau(1)->get_start_datetime();

my $config = Object::Config->new({users => $list_users,
								  creneaux => $list_creneaux
								 });

#print $config->get_user(1)->get_souhait_nuit;
#print $config->get_creneau(2)->get_end_datetime;


# test matrix Pheromone
my $matrix = Mmas::Pheromone->new({n_col => 2,
				   n_row => 5
				  });


$matrix->initialize($config, 9);
$matrix->set_val(2, 1, 10);
print Dumper $matrix->get_val(2,1);
