package SamuApp::Controller::Admin::Group;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->config(
  action_roles => ['QueryParameter'],
);


=head1 NAME

SamuApp::Controller::Admin::Group - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SamuApp::Controller::Admin::Group in Admin::Group.');
}

sub base :Chained('/') :PathPart('admin/group') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

    #store the Resultset DB::groups in stash
    $c->stash(resultset => $c->model('DB::Group'));

    #print log message
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

sub group :Chained('base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    my $params = $c->request->query_params;
    my $id = $params->{'group_id'};

    $c->stash(group => $c->stash->{resultset}->find($id));

    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{object};
    die "User $id not found!" if !$c->stash->{group};
 
    # Print a message to the debug log
    $c->log->debug("*** INSIDE GROUP METHOD for group_id=$id ***");
	 
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;
    my $text = "list des groups";

    $c->stash(groups => [$c->model('DB::Group')->all]);

    $c->stash(template => 'admin/group/list_groups.tt2', text => $text);
    
}

sub show :Chained('group') :PathPart('show') :Args(0) {
    my ( $self, $c ) = @_;

    my @users = $c->stash->{group}->appartient_utilisateurs;

    $c->stash( users => \@users );

    $c->stash( template => 'admin/group/detail_group.tt2' );

}

sub edit :Path('edit') :Args(0) {
    my ( $self, $c ) = @_;
    
}

sub delete :Path('delete') :Args(0) {

}

=encoding utf8

=head1 AUTHOR

Hoeël,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
