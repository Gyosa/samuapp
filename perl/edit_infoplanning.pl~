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
  
while (my $line = <$data>)  
{ 
    chomp $line; 
  
    # Split the line and store it 
    # inside the words array 
    my @words = split ";", $line;   
	my $letter = substr($words[3], 0, 1);
	my $other = $words[2];
	my $auth = "$letter$other";
	
	my $user = $schema->resultset('Utilisateur')->create({
		utilisateur_role => 'user',
		utilisateur_auth => $auth,
		utilisateur_password => 'password',
		utilisateur_nom =>$words[2],
		utilisateur_prenom =>$words[3],
		utilisateur_mail => $words[1],
		utilisateur_phone => $words[0]
														 });
} 
