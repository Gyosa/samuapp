package SamuApp::Controller::Admin::Planning;
use Moose;
use namespace::autoclean;

use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SamuApp::Controller::Admin::Planning - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SamuApp::Controller::Admin::Planning in Admin::Planning.');
}


sub list :Chained('base') :PathPart('list') :Args(0) {
	my ( $self, $c ) = @_;
	my $text = "liste des plannings";

	$c->stash(plannings => [$c->stash->{resultset}->all]);

	$c->stash(template => 'admin/planning/list_planning.tt2', text => $text);
}

sub base :Chained('/') :PathPart('admin/planning') :CaptureArgs(0) {
	my ( $self, $c ) = @_;

	# Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::Planning'));
 
    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

sub object :Chained('base') :PathPart('') :CaptureArgs(0) {
	my ($elf, $c) = @_;
	my $params = $c->request->query_params;
	my $id = $params->{'planning_id'};
	
	# get the planning resultset
	my $planning = $c->stash->{resultset}->find($id);
	$c->stash(planning => $planning);
	die "User $id not found!" if !$c->stash->{planning};

	# get the list of créneaux for this planning
	my @creneaux = $planning->creneaus;
	$c->stash(creneaux => \@creneaux);
	
	$c->log->debug("*** INSIDE OBJECT METHOD for obj id=$id ***");
}

use Types::Standard 'Int';
sub show_wi :Chained('object') :PathPart('show') :Args(0) QueryParam('planning_id'){
	my ( $self, $c ) = @_;

	#my $params = $c->request->query_params;
	#$c->stash(id => Dumper($params->{'planning_id'}));

	my $planning = $c->stash->{planning};
	#$c->stash(planning => $planning);

	#liste des utilisateurs du planning
	my @participants = $planning->participeplanning_utilisateurs;

	#list des créneau de chaque utilisateur	
	my @res;
	for my $user (@participants){
		my @creneaux = list_creneau_user_per_planning( $self, $c, $planning->planning_id, $user->utilisateur_id );
		my @temp;
		push (@temp, $user, scalar(@creneaux));
		push (@res, \@temp);
	}

	$c->stash(participants => \@res);
	#$c->stash(participants => \@participants);	
	$c->stash(template => 'admin/planning/detail_planning.tt2');
}

sub list_creneau_user_per_planning {
	my ( $self, $c, $planning_id, $user_id ) = @_;
	
	my $planning = $c->model('DB::Planning')->find($planning_id);
	my $user = $c->model('DB::Utilisateur')->find($user_id);
	$c->log->debug("many to many");
	my $all_creneau_user = $user->remplicreneau_creneaus;

	my %where = ( planning_id => $planning_id);
	my $creneau_user = $all_creneau_user->search(\%where);

	return $creneau_user;
	
}

sub edit :Chained('object') :PathPart('edit') :Args(0) {
	my ($self, $c) = @_;

}

sub delete :Chained('object') :PathPart('delete') :Args(0) {
	my ($self, $c) = @_;

}

#use SamuApp::Controller::Admin::PlanningCreate qw(creneaux_create);
use SamuApp::Form::Planning;
sub form {
	my ($self, $c, $planning) = @_;

	my $form = SamuApp::Form::Planning->new;
	$c->stash( template => 'admin/planning/form_planning.tt2', form => $form);
	$form->process (posted => ($c->req->method eq 'POST'), item => $planning, params => $c->req->params );
	$c->log->debug("form VALIDATED = $form->validated");

	return unless $form->validated;
	
	### encapsule fonction ###
	# call create_creneaux
	my $flag = create_creneaux($self, $c, $planning);
	$c->log->debug("flag function creneaux : $flag");

	# create link between planning ans users
	### find a way to allow only concerned user ( with group ? )
	insert_users_planning_db($self, $c, $planning);
	# create Info planning for user
	insert_info_planning_db($self, $c, $planning);
	
	### end encapsulation ###
	$c->response->redirect($c->uri_for($self->action_for('list'), {mid => $c->set_status_msg("planning added")}));
}

sub create :Path('create') :Args(0) {
	my ($self, $c) =@_;
	
	my $planning = $c->model('DB::Planning')->new_result({});

	return $self->form($c, $planning);
}	

#### function for calcul of planning ####
use Date::Calc;
use XML::LibXML;


## génération des créneaux ##
sub create_creneaux ($$$) {
	my ( $self, $c, $planning) = @_;
	#planning is resultset of Planning from DB

	# my xml parser with creneaux def and execption
	my $doc = open_file($c, "planning_create.xml");
	### match planning type in doc to return the good one node;
	my $node = $doc->getElementsByTagName($planning->planning_type); # name of non hardcode
	
	my $planning_type = $planning->planning_type;
	if ($planning_type eq 'regulateur'){
		$self->create_creneaux_regulateur($c, $planning, $node->[0]);
	}elsif ($planning_type eq 'mobile'){

	}elsif ($planning_type eq 'mmg'){

	}else{
		$c->log->debug("planning_type does't exist : $planning_type'");
	}
	
	#$c->log->debug("id planning : ");
	return 1;
}

sub create_creneaux_regulateur  {
	my ($self, $c, $planning, $node ) = @_;

	# def of date var
	my $start_date = $planning->planning_start_date;
	my $end_date = $planning->planning_end_date;
	my $iterate_date = $start_date;

	while ( DateTime->compare ($iterate_date, $end_date) < 1){
		# do action
		### is a special day ??
		# is_special_day($iterate_date);
		
		### match datetime with date
		my $day_name = day_name($iterate_date);
		
		### search coorespond config in $doc
		### ref to list of href config
		my $configs = search_config_xml($c, $node, $day_name);
	
		### create creneau with param
		insert_creneaux_db($c, $planning, $iterate_date, $configs);

		### log game on each day ###
		#my $test = Dumper($configs);
		#$c->log->debug("Dumper config: $test");	
		### end log ###
		#iterate on date
		$iterate_date->add( days => 1);
	}
	
	#my $test = Dumper($planning->planning_start_date);
	#$c->log->debug("date time data : $test");
	return 1;
	
}

sub insert_creneaux_db {
	my ($c, $planning, $iterate_date, $configs) = @_;
	
	for my $config (@$configs){
		
		my $date = DateTime->new(year => $iterate_date->year, month => $iterate_date->month, day => $iterate_date->day);
		my @start_time = split /:/, $config->{startTime};
		my $start_date = $date->add( days => $config->{startDate}, hours => $start_time[0], minutes => $start_time[1], seconds => $start_time[2]);
		
		my $date = DateTime->new(year => $iterate_date->year, month => $iterate_date->month, day => $iterate_date->day);
		my @end_time = split /:/, $config->{endTime};
		my $end_date = $date->add( days => $config->{endDate}, hours => $end_time[0], minutes => $end_time[1], seconds => $end_time[2]);
		
		my $creneau = $c->model('DB::Creneau')->create({
			creneau_planning_id => $planning->planning_id,
			creneau_type => "creneau",
			creneau_start_datetime => $start_date,
			creneau_end_datetime => $end_date,
			creneau_nbpersonnes => $config->{nbpersonnes}
			});
	}
}

### deprecated
sub increment_date  {
	my ($self, $date) = @_;
	if ($date->is_last_day_of_month()){
		if($date->is_last_day_of_year()){
			   $date->set({year =>$date->year + 1, month => 01 , day => 01}); 
		   }else{
			   $date->set_month($date->month + 1);
		   }
	}else{
		$date->set_day($date->day + 1);
	}
	return $date;
}

sub day_name  {
	my ($date) = @_;

	my %days = ( 1 => "lundi",
				 2 => "mardi",
				 3 => "mercredi",
				 4 => "jeudi",
				 5 => "vendredi",
				 6 => "samedi",
				 7 => "dimanche");

	return $days{$date->day_of_week()};
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

sub search_config_xml  {
	my ($c, $node, $day_name) = @_;
	my @res;
	
	my $day_creneaux_config = $node->getElementsByTagName($day_name);
	my @creneaux_config = $day_creneaux_config->[0]->getElementsByTagName("creneau");
	for my $creneau (@creneaux_config){
		my %config;
		$config{nbpersonnes} = $creneau->findnodes('nbPers')->[0]->firstChild->data;
		$config{startDate} = $creneau->findnodes('startDate')->[0]->firstChild->data;
		$config{startTime} = $creneau->findnodes('startTime')->[0]->firstChild->data;
		$config{endDate} = $creneau->findnodes('endDate')->[0]->firstChild->data;
		$config{endTime} = $creneau->findnodes('endTime')->[0]->firstChild->data;
		push (@res, \%config);
	}
	return \@res;
	
}

sub insert_users_planning_db {
	my ($self, $c, $planning) = @_;
	my %where = (utilisateur_role => 'user');
	my @users = $c->model('DB::Utilisateur')->search(\%where);
	for my $user (@users){
		$c->model('DB::Participeplanning')->create({
			participeplanning_utilisateur_id => $user->utilisateur_id,
			participeplanning_planning_id => $planning->planning_id
			});
	}
}

sub insert_info_planning_db {
	my ($self, $c, $planning) = @_;
	my @users = $planning->participeplanning_utilisateurs;

	for my $user (@users){
		my $info_planning = $c->model('DB::InfoPlanning')->create({
			infoplanning_planning_id => $planning->planning_id,
			infoplanning_utilisateur_id => $user->utilisateur_id
			});
	}
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
