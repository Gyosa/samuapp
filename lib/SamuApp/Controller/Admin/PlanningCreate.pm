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

sub list :Path('list') :Args(0) {
    my ($self, $c) = @_;

}

sub create_planning :Path('create_planning') :Args(0) {
    my ($self, $c) = @_;
    
    $c->stash( template => 'admin/planning/planning_create.tt2' );
}

sub post_form :Path('post_form') :Args(0) {
    my ($self, $c) = @_;
    
    my $params = $c->request->body_params;

    $c->log->debug('BODY PARAMS'. Dumper($params));

    $c->forward('fdv_profile');
    my $profile = $c->stash->{dfv_profile};

    my $result = Data::FormValidator->check( $params, $profile);

    $c->log->debug('DFV RESULT'.Dumper($result));
    if ($result->has_invalid || $result->has_missing){
	#Send Global Message
	$c->stash( template => 'admin/planning/planning_create.tt2' );
    }else{#edit xml file
	#open file

	#add node
    }
	

}

sub dfv_profile :Private {
    my ($self, $c) = @_;
}

sub open_file ($$){
	my ($c, $name_file) = @_;
	# need to match with file name
	my @files = $c->model('File')->list;
	#my $test = Dumper(@files);
	
	my $file = "$files[0]->{dir}/$files[0]->{file}";
	$c->log->debug("file name $file");
	
	my $doc = new XML::LibXML->load_xml(location => $file);
	$c->log->debug(Dumper($doc));
	return $doc;
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
