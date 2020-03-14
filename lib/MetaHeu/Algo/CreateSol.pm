package Algo::CreateSol;
 
use strict;
use warnings;


### input ###
# config one configuration (list creneaux & user)
# params metaheu parameters
#
### output ###
# s a solution for a config (rng)

sub create_solution(){
	my ($self, $config, $param)  = @_;

	my @results = @$config;
	my $users = $results[0];
	my @users = @$users;
	my $creneaux = $results[1];
	my @creneaux = @$creneaux;
	

	
	# iterate over creneaux
	for my $creneau (@creneaux){
		my $i_table = $@creneau[0];
		my @creneau = $@creneau[1];
		my $nb_personne = $@creneau[1];
	#   # iterate over nb_creneau
		while $nb_personnes =! 0 {
	#	#	# placer utilisateur pour ce creneaux
			my @user = tirage_user(@creneau, @users)
	
	


	#export result
	
}
sub tirage_user {
	my(@creneau, @users) = @_;
	
	# tirage pseudo_aléatoire
	my @user = tirage(@creneau, @users);
	# trough rules
	
	# return
	return @user;
}
sub tirage {
	my (@creneau, @users) = @_;
	my $rnd(1,n_users);
	my @temp
	return @users
sub rules{
	my (@creneaux, @user) = @_;

	return false;

	return true;
}
1;
