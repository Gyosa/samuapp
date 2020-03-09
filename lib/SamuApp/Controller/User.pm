package SamuApp::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SamuApp::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $user = $c->user;
    $c->response->body('user_id:'+ $user->utilisateur_id +' & auth: '+$user->utilisateur_auth);
}

sub base :Chained('/') :PathPart('user') :CaptureArgs(0) {
	my ( $self, $c ) = @_;
	#my $user = $c->user;
	
	#$c->response->body($user->utilisateur_auth);
	#$c->response->body("user_id: $user->utilisateur_id & auth: $user->utilisateur_auth");
}

sub object :Chained('base') :PathPart('') :CaptureArgs(0){
	my ($self, $c) = @_;
	# get planning et creneaux for this user!
	my $user_id = $c->user->utilisateur_id;
	# plannings
	my %where = ();
	my @plannings = $c->user->participeplanning_plannings;

	# creneaux
	my @creneaux = $c->user->remplicreneau_creneaus;

	#insert in stash
	$c->stash(plannings => \@plannings, creneaux => \@creneaux);

	$c->log->debug("*** INSIDE OBJECT METHOD for user id=$user_id ***");
}

sub dashboard :Chained('object') :PathPart('dashboard') Args(0){
	my ($self, $c) = @_;

	$c->stash(template => ('user/dashboard.tt2'));

}

sub info :Path('info') Args(0) {
	my ($self, $c) = @_;

	#my $user_id = $c->user->utilisateur_id;
	#my $user_auth = $c->user->utilisateur_auth;

	$c->stash(template =>'user/info.tt2', utilisateur => $c->user);
}
=encoding utf8

=head1 AUTHOR

hoel,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
