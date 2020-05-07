package SamuApp::Controller::Admin::Group;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

__PACKAGE__->config(
  action_roles => ['QueryParameter'],
);

use Data::Dumper;

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

    if ($id eq ''){
	$c->log->debug("*** INSIDE GROUP METHOD no given ID ***");
    }else {
	$c->stash(group => $c->stash->{resultset}->find($id));
	# Print a message to the debug log
	$c->log->debug("*** INSIDE GROUP METHOD for group_id=$id ***");
    }
 
    # Print a message to the debug log
    #$c->log->debug("*** INSIDE GROUP METHOD for group_id=$id ***");
	 
}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

    my $text = "list des groups";
    my $groups = [$c->model('DB::Group')->all];

    for my $group (@$groups){
	my $nb;
	my $rs = $c->model('DB::Appartient')->search({appartient_groups_id => $group->groups_id});
	$nb = scalar($rs);
	$group->{nb_utilisateurs} = $nb;
    }
    
    $c->stash(groups => $groups);

    $c->stash(template => 'admin/group/list_groups.tt2', text => $text);
    
}

sub show :Chained('group') :PathPart('show') :Args(0) {
    my ( $self, $c ) = @_;

    my @users = $c->stash->{group}->appartient_utilisateurs;

    $c->stash( users => \@users );

    $c->stash( template => 'admin/group/detail_group.tt2' );

}

sub form :Chained('group') :PathPart('form') :Args(0){
    my ( $self, $c ) = @_;

    # if valid_args are defined
    $c->log->debug("Dump ValidArgs:".Dumper($c->stash->{valid_args}));
    $c->log->debug("Dump msgs:".Dumper($c->stash->{msgs}));

    #make test for update without fail DFV before
    if (defined $c->stash->{group} && !defined $c->stash->{valid_args}) {
	$c->stash->{valid_args}->{groups_name} = $c->stash->{group}->groups_name;
	$c->stash->{valid_args}->{groups_description} = $c->stash->{group}->groups_description;
    }
    
    $c->forward('get_users');
    #$c->log->debug("Dump users:".Dumper($c->stash->{utilisateurs}));
    
    $c->stash( template => 'admin/group/create_group.tt2');
}

sub post_form :Chained('group') :PathPart('post_form') :Args(0) {
    my ( $self, $c ) = @_;

    my $params = $c->request->body_params;

    $c->forward('dfv_profile');
    my $profile = $c->stash->{dfv_profile};

    my $result = Data::FormValidator->check( $params, $profile);

    $c->log->debug(Dumper($result));
    if ($result->has_invalid || $result->has_missing){
	#Send Global Message !
	
	$c->stash->{valid_args} = $result->valid;
	$c->stash->{msgs} = $result->msgs;
	
	#redirect to form with valid arg       
	$c->go('form');
    }
    else{# insert value in Database

	my $args = $result->valid;
	my $group_data = { groups_name => $args->{groups_name},
			   groups_description => $args->{groups_description}};
	$c->log->debug("valid:".Dumper($args));
      
	#in case of creation
	my $group;
	if ( ! defined $c->stash->{group} ) {
	    #create group
	    $group = $c->model('DB::Group')->create($group_data);
	}else{
	    #update group
	    $group = $c->stash->{group};
	    $group->update($group_data);
	}

	#if groups_utilisateurs is not defined, set empty array
	if (!defined $args->{groups_utilisateurs}){
	    $args->{groups_utilisateurs} = [];
	}
	# call methods for user
	$c->log->debug("GROUP".$group);
	$c->log->debug("USERS".$args->{groups_utilisateurs});
	$c->forward('set_users', [$group, $args->{groups_utilisateurs}]);

	# redirect to groupes list
	$c->res->redirect( $c->uri_for_action('admin/group/list'));
    }

}

sub delete :Chained('group') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    die "$c->stash->{group} not defined" if !defined $c->stash->{group};
    
    $c->stash->{group}->delete;
    
    $c->res->redirect( $c->uri_for_action('admin/group/list'));
}


sub dfv_profile :Private {
    my ($self, $c ) = @_;
    my $profile = {
	required => [ qw/groups_name/ ],
        optional => [ qw/groups_description groups_utilisateurs/ ],
        filters => 'trim',
        constraint_methods => {
	   groups_name => [{
		constraint_method => qr/\d*/,
		name => 'name',
		     }],
	   groups_description => [{
		constraint_method => qr/\d*/,
		name => 'description',
				  }],
	   groups_utilisateurs => [{
	       constraint_method => sub ([qw/groups_utilisateurs/]){
		   my @users_id = @_;
		   my $flag = 1;
		   for my $user_id (@users_id){
		       my $user = $c->model('DB::Utilisateur')->find($user_id);
		       $flag = 0 && last if ( !defined $user );	   
		   }
		   if (scalar(@users_id) == 0){$flag = 0;}
		   
		   return $flag;
	       },
	       name => "groups_utilisateurs",
				   }]
	       
        },
	msgs => {
            format => '%s',
            prefix => '',
            missing => 'obligatoire',
            invalid => 'valeur incorrecte',
            constraints => {
		groupe_description => 'Not balnk & caractères alpanumériques',
		groupe_name => 'Not Blank',
            }
	    
        },
    };

    $c->stash->{dfv_profile} = $profile;
}

sub get_users :Private {
    my ($self, $c) = @_;

    my @user_out;
    my @user_in;

    ###test in case of fail FormValidation
    if ( defined $c->stash->{valid_args}->{groups_utilisateurs}) {
	my @user_id_in;
	if (ref($c->stash->{valid_args}->{groups_utilisateurs}) eq 'ARRAY'){
	    for my $user_id (@{$c->stash->{valid_args}->{groups_utilisateurs}}){
		push(@user_id_in, $user_id);
	    }
	}else{
	    push(@user_id_in, $c->stash->{valid_args}->{groups_utilisateurs});
	}
	$c->log->debug("get_users:".Dumper(@user_id_in));
	my %where_in = (utilisateur_id => {-in=>\@user_id_in});
	@user_in = $c->model('DB::Utilisateur')->search(\%where_in);
	
	
	my %where_out = (utilisateur_id => {-not_in=>\@user_id_in});
	@user_out = $c->model('DB::Utilisateur')->search(\%where_out);
    }
    ###test if group is defined in case of group creation
    elsif ( defined $c->stash->{group} ) {
	#get users in this group
	@user_in = $c->stash->{group}->appartient_utilisateurs;
    
	#get users out of this group
	my @group_user_id;
	for my $user ($c->stash->{group}->appartient_utilisateurs){
	    push (@group_user_id, $user->utilisateur_id);
	}
	my %where = (utilisateur_id => {-not_in=>\@group_user_id});
	@user_out = $c->model('DB::Utilisateur')->search(\%where);
    }else{
	@user_out = $c->model('DB::Utilisateur')->all;
    }
    
    my %utilisateurs = (in => \@user_in,
			out => \@user_out
	);
    $c->stash->{utilisateurs} = \%utilisateurs;
	
}

sub set_users :Private {
    my ($self, $c, $group, $users) = @_;

    $c->log->debug("\n"x5);
    $c->log->debug("GROUP".$group);
    $c->log->debug("USERS".$users);
    #delete old users
    #$c->log->debug($users."\n".Dumper($users));
    if (ref($users) ne 'ARRAY') {
	$users = [$users];
    }
    
    my %where = (appartient_utilisateur_id => {-not_in => $users},
		 appartient_groups_id => $group->groups_id);
    my $rs_d = $c->model('DB::Appartient')->search(\%where);
    #pb de deletions avec d'autres groupes!
    $rs_d->delete;
    
    #set new users
    ###find or create

    for my $user_id (@$users){
	my $rs_c = $c->model('DB::Appartient')->find_or_create(('appartient_groups_id', $group->groups_id, 'appartient_utilisateur_id', $user_id));
	}

    #don't touch curent users
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
