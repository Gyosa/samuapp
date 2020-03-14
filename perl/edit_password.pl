#!/usr/bin/perl
 
use strict;
use warnings;
use lib '../lib';
use SamuApp::Schema;
 
my $schema = SamuApp::Schema->connect('dbi:Pg:dbname=samuapp;host=localhost', 'catalyst', 'catalyst');
 
my @users = $schema->resultset('Utilisateur')->all;
 
foreach my $user (@users) {
    $user->utilisateur_password('password');
    $user->update;
}
