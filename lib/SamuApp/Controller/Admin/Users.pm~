package SamuApp::Controller::Admin::Users;
use Moose;
use MooseX::MethodAttributes;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->config(
  action_roles => ['QueryParameter'],
);


=head1 NAME

SamuApp::Controller::Admin::Users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SamuApp::Controller::Admin::Users in Admin::Users.');
}

sub list :Path('list') :Args(0) {
	my ( $self, $c ) = @_;
	my $text = "liste des utilisateurs";
	
	$c->stash(utilisateurs => [$c->model('DB::Utilisateur')->all]);

	$c->stash(template => 'admin/users/list_users.tt2', text =>$text);

}

=head set prority for same path but no args
sub show_wo :Path('show') :Args(0) {
	my ( $slef, $c ) = @_;

	$c->response->body('Not a good url');
}
=cut

use Types::Standard 'Int';
sub show_wi :Path('show') :Args(0) QueryParam('user_id'){
	my ( $self, $c ) = @_;
	# récupération des paramètres de l'url
	# en faire une fonction qui retour une hash
	my $params = $c->request->query_params;	
	
	$c->stash(id =>  Dumper($params->{'user_id'}));

	# clause where de l'uilisateur en question
	my %where = ( "utilisateur_id" => $params->{'user_id'});

	# affichage template
	$c->stash(utilisateur => $c->model('DB::Utilisateur')->find($params->{'user_id'}));
	
	$c->stash(template => 'admin/users/detail_user.tt2');

}

=head2 base
 
Can place common logic to start chained dispatch here
 
=cut
 
sub base :Chained('/') :PathPart('admin/users') :CaptureArgs(0) {
    my ($self, $c) = @_;
 
    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::Utilisateur'));
 
    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 object
 
Fetch the specified book object based on the book ID and store
it in the stash
 
=cut
 
sub object :Chained('base') :PathPart('') :CaptureArgs(0) {
    my ($self, $c) = @_;
	my $params = $c->request->query_params;
	my $id = $params->{'user_id'};
 
    # Find the book object and store it in the stash
    $c->stash(object => $c->stash->{resultset}->find($id));
 
    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{object};
    die "User $id not found!" if !$c->stash->{object};
 
    # Print a message to the debug log
    $c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

use SamuApp::Form::Users;
sub create :Chained('base') :PathPart('create') :Args(0) {
	my ( $self, $c ) = @_;

	my $user = $c->model('DB::Utilisateur')->new_result({});
	#my $user = $c->model('DB::Utilisateur')->find(1);
	return $self->form($c, $user);
}
sub form {
	my ( $self, $c, $user ) = @_;

	my $form = SamuApp::Form::Users->new;
	#set the template
	$c->stash( template => 'admin/users/form_users.tt2', form => $form);
	$form->process (posted => ($c->req->method eq 'POST'), item => $user, params => $c->req->params );
	$c->log->debug("form VALIDATED = $form->validated");
	
	return unless $form->validated;
	#return unless 0;
	#set a status message for the user and redirect url to user list
	$c->response->redirect($c->uri_for($self->action_for('list'),{mid => $c->set_status_msg("user added")}));
}

sub edit  :Chained('object') :PathPart('edit') :Args(0) {
	my ( $self, $c ) = @_;

    return $self->form($c, $c->stash->{object});
}

sub delete :Chained('object') :PathPart('delete') :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{object}->delete;

	$c->stash->{status_msg} = "User deleted";

	$c->forward('list');
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
