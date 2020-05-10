#!/usr/bin/perl
 
use strict;
use warnings;
 
use SamuApp::Schema;


my $schema = SamuApp::Schema->connect('dbi:Pg:dbname=samuapp;host=localhost', 'catalyst', 'catalyst');

=head
my @users = $schema->resultset('Utilisateur')->all;
 
foreach my $user (@users) {
    $user->utilisateur_password('password');
    $user->update;
}
=cut

#import csv file for all users data
### their personal info and info planning
use strict; 
  
my $file = $ARGV[0] or die; 
open(my $data, '<', $file) or die; 
my $id_planning = $ARGV[1];

while (my $line = <$data>)  
{ 
    chomp $line; 
  
    # Split the line and store it 
    # inside the words array 
    my @words = split ";", $line;   

	
	my @user = $schema->resultset('Utilisateur')->search({
		utilisateur_nom => $words[2]});
	my $user = $user[0];

	my @info = $schema->resultset('Infoplanning')->search({
		infoplanning_utilisateur_id => $user->utilisateur_id,
		infoplanning_planning_id => $id_planning});
	my $info = $info[0];
=head
	my $x  = 10;
	my $jour= ($words[4]!=0) ? $words[4] + $x  : 0 ;
	my $nuit= ($words[5]!=0) ? $words[5] + $x  : 0 ;
=cut
	#345 souhait
	$info->infoplanning_souhait_jour($words[4]);
	$info->infoplanning_souhait_nuit($words[5]);
	$info->update;
} 
