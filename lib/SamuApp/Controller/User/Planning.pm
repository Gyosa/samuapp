package SamuApp::Controller::User::Planning;
use Moose;
use namespace::autoclean;

use Data::Dumper;
	
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SamuApp::Controller::User::Planning - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SamuApp::Controller::User::Planning in User::Planning.');
}

sub base :Chained('/') :PathPart('user/planning') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
	# charge in stash the resulset plannings of this user

	#my $user_id = $c->user->utilisateur_id;
	my $rs_plannings = $c->user->participeplanning_plannings;

	$c->stash(rs_plannings => $rs_plannings, plannings => [$rs_plannings->all]);
 
}

sub planning :Chained('base') :PathPart('') :CaptureArgs(0) {
	my ( $self, $c) = @_;
	my $params = $c->request->query_params;
	my $planning_id = $params->{'planning_id'};

	my $planning = $c->stash->{rs_plannings}->find($planning_id);

	my %cond = ( utilisateur_id => $c->user->utilisateur_id);
	my %where = ( join => {'remplicreneaus' => 'remplicreneau_utilisateur'});

	my @creneaux = $planning->creneaus->search(\%cond, \%where);;
                                          
	$c->stash(planning => $planning, creneaux => \@creneaux);
	
}

sub c_info_planning :Chained('planning') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
	
	my %cond = (
		infoplanning_planning_id => $c->stash->{planning}->planning_id,
		infoplanning_utilisateur_id => $c->user->utilisateur_id
		);
	my @infoplanning = $c->model('DB::Infoplanning')->search(\%cond);
	### test if exist and is alone or set primary key on (utilisateur_id et planning_id) for Infoplanning table
	
	$c->stash(infoplanning => $infoplanning[0]);
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(template => 'user/planning/list_planning.tt2');
}

sub show_detail :Chained('planning') :PathPart('detail') :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(template => 'user/planning/detail_planning.tt2');
}

sub show_info_planning :Chained('c_info_planning') :PathPart('info_planning') :Args(0) {
    my ( $self, $c ) = @_;
	
    $c->stash(template => 'user/planning/info_planning.tt2');
}

sub edit_info_planning :Chained('c_info_planning') :PathPart('edit_info_planning') :Args(0) {
    my ( $self, $c ) = @_;

    return $self->form($c, $c->stash->{infoplanning});
}
use SamuApp::Form::InfoPlanning;
sub form {
	my ( $self, $c, $info_planning ) = @_;

	my $form = SamuApp::Form::InfoPlanning->new;
	#set the template
	$c->stash(template => 'user/planning/form_info_planning.tt2', form => $form);
	$form->process(posted => ($c->req->method eq 'POST'), item => $info_planning, params => $c->req->params );

	return unless $form->validated;

	my $uri = $c->uri_for($self->action_for('list'), {planning_id => $c->stash->{planning}->planning_id, mid => $c->set_status_msg("Information planning modified")});
	
	$c->response->redirect($uri);
	
	#$c->response->redirect($uri_base);
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
