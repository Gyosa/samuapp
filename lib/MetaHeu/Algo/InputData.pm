package Algo::InputData;
use strict;
use warnings;
#use diagnostics;

#BEGIN { push @INC,  '../../lib/' }
use lib '../../lib';
#use lib '..';

use SamuApp::Schema;
use DateTime;
use Data::Dumper;

sub input_data {
my $schema = SamuApp::Schema->connect('dbi:Pg:dbname=samuapp;host=localhost', 'catalyst', 'catalyst');

my $planning_id = $ARGV[0];

# génération des data pour l'algorithme
my @users;
my @creneaux;
# sub input_data {
	# génération des users	
	my @utilisateurs = $schema->resultset('Utilisateur')->all;
	my $i=0;
	my $i_max = scalar(@utilisateurs);
	
	while ($i<$i_max){
		my $user_id = $utilisateurs[$i]->utilisateur_id;
		
		my @infos = $schema->resultset('Infoplanning')->search({
			infoplanning_utilisateur_id => $user_id,
			infoplanning_planning_id => $planning_id});
		my $info = $infos[0];
		#return Dumper @infos;
		my $souhait_jour = $info->infoplanning_souhait_jour;
		my $souhait_nuit = $info->infoplanning_souhait_nuit;
		
		my @temp = (
			$user_id,
			$souhait_jour,
			$souhait_nuit
			);
		push(@users, $i, \@temp);
		$i += 1;
	}
	
	#generation des creneaux	
	my $planning = $schema->resultset('Planning')->find($planning_id);
	my @creneaus = $planning->creneaus;
	my $j = 0;
	for my $cren (@creneaus) {
		my @temp = (
			$cren->creneau_id,
			$cren->creneau_nbpersonnes,
			$cren->creneau_start_datetime,
			$cren->creneau_end_datetime
			);
		push(@creneaux, $j, \@temp);
		$j += 1;
	}
#return @users;

my @temp;
push (@temp, \@users,\ @creneaux);
return \@temp;
}





### MAIN ###

#initailize data from app

# get n solution
### eval objectif function on all solution

### select  

#input_data();
#print Dumper (@creneaux);
#return \@creneaux;

#__PACKAGE__->meta->make_immutable;
1;
