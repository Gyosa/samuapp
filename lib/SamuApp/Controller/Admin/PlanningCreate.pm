package SamuApp::Controller::Admin::PlanningCreate;
use Moose;
use namespace::autoclean;

use Data::Dumper;
use Date::Calc;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SamuApp::Controller::Admin::PlanningCreate - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut
	
#### all function are PRIVATE ####


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SamuApp::Controller::Admin::PlanningCreate in Admin::PlanningCreate.');
}

sub create_planning {
	
}

sub create_creneaux ($$$) {
	my ( $self, $c, $planning) = @_;
	#planning is resultset of Planning from DB

	$c->log->debug("id planning : $planning->planning_id ");
	return 1;
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
