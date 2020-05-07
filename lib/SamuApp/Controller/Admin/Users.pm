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

sub user :Chained('base') :PathPart('') :CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->log->debug("*** USER METHOD BEFORE REQUEST ***");
    my $params = $c->request->query_params;
    my $id = $params->{'user_id'};
 
    if ( $id eq '') {
	$c->log->debug("*** INSIDE USER METHOD no given ID ***");
    }else{
	$c->stash(utilisateur => $c->stash->{resultset}->find($id)); 
	# Print a message to the debug log
	$c->log->debug("*** INSIDE USER METHOD for user_id=$id ***");
    }
}

sub list :Chained('base') :PathPart('list') :Args(0) {
	my ( $self, $c ) = @_;
	my $text = "liste des utilisateurs";
	
	$c->stash(utilisateurs => [$c->model('DB::Utilisateur')->all]);

	$c->stash(template => 'admin/users/list_users.tt2', text =>$text);

}

#QueryParam('user_id')
sub show :Chained('user') :PathPart('show') :Args(0) {
    my ( $self, $c ) = @_;

    my $user = $c->stash->{utilisateur};
    #show user group appartenace
    my $groups = [$user->appartient_groups];
    
    for my $group (@$groups){
	$c->log->debug("GROUP".Dumper($group));
	my $nb;
	my $rs = $c->model('DB::Appartient')->search({appartient_groups_id => $group->groups_id});
	$nb = scalar($rs);
	$group->{nb_utilisateurs} = $nb;
    }
    $c->stash->{groups} = $groups;

    #show user planning appartenance
    $c->stash->{plannings} = [$user->participeplanning_plannings];
    
    $c->stash(template => 'admin/users/detail_user.tt2');

}

sub form :Chained('user') :PathPart('form') :Args(0){
    my ( $self, $c ) = @_;

    #make test for update without fail DFV before
    if (defined $c->stash->{utilisateur}){
	$c->stash->{hide_password} = 1;
	if (!defined $c->stash->{valid_args}){
	my $user = $c->stash->{utilisateur};
	my %valid_args = (user_auth => $user->utilisateur_auth,
			  user_role => $user->utilisateur_role,
			  user_name => $user->utilisateur_prenom,
			  user_lastname => $user->utilisateur_nom,
			  user_mail => $user->utilisateur_mail,
			  user_phone => $user->utilisateur_phone);
	$c->stash->{valid_args} = \%valid_args;
	}		  
    }

    $c->stash( template => 'admin/users/form_users.tt2');

}

sub post_form :Chained('user') :PathPart('postform') :Args(0) {
    my ($self, $c) = @_;

    my $params = $c->request->body_params;

    $c->forward('dfv_profile');
    my $profile = $c->stash->{dfv_profile};

    my $result = Data::FormValidator->check( $params, $profile);
    $c->log->debug("DFV result".Dumper($result));

    if ($result->has_invalid || $result->has_missing){
	#send Global message !

	$c->stash->{valid_args} = $result->valid;
	$c->stash->{msgs} = $result->msgs;

	$c->go('form');
    }else{ #insert value in Database
	my $args = $result->valid;
	my $user_data = { utilisateur_auth => $args->{user_auth},
			  utilisateur_role => $args->{user_role},
			  utilisateur_prenom => $args->{user_name},
			  utilisateur_nom => $args->{user_lastname},
			  utilisateur_mail => $args->{user_mail},
			  utilisateur_phone => $args->{user_phone}
	};

	# in case of creation
	my $user;
	if ( !defined $c->stash->{utilisateur} ) {
	    #insertion du password dans la data
	    $user_data->{utilisateur_password} = $args->{user_password};
	    # create user
	    $user = $c->stash->{resultset}->create($user_data);
	}else{
	    #update user
	    $user = $c->stash->{utilisateur};
	    $user->update($user_data);
	}

	#redirect to user list
	$c->res->redirect( $c->uri_for_action('admin/users/list'));
    }
    
}

sub delete :Chained('user') :PathPart('delete') :Args(0) {
    my ($self , $c) = @_;

    die "$c->stash->{utilisateur} not defined" if !defined $c->stash->{utilisateur};

    $c->stash->{utilisateur}->delete;

    $c->res->redirect( $c->uri_for_action('admin/users/list'));
    
}

    
sub dfv_profile :Private {
    my ($self, $c ) = @_;
    my $profile = {
	required => [ qw/user_auth user_role user_name user_lastname user_mail user_phone/ ],
        optional => [ qw/user_password/ ],
        filters => 'trim',
        constraint_methods => {
	    user_auth => [{
		constraint_method => qr/\d*/,
		name => 'auth',
			  }],
	    #specifique from psql
	    user_password => [{
		constraint_method => qr/\d*/,
		name => 'password',
			  }],
	    #specifique from psql
	    user_role => [{
		constraint_method => qr/\d*/,
		name => 'role',
			  }],
	    user_name => [{
		constraint_method => qr/\d*/,
		name => 'prenom',
			    }],
	    user_lastname => [{
		constraint_method => qr/\d*/,
		name => 'nom',
			 }],
	    user_mail => [{
		constraint_method => qr/\d*/,
		name => 'mail',
			  }],
	    user_phone => [{
		constraint_method => qr/\d*/,
		name => 'phone',
			   }]

	       
        },
	msgs => {
            format => '%s',
            prefix => '',
            missing => 'obligatoire',
            invalid => 'valeur incorrecte',
            constraints => {
		user_auth => 'Not balnk & caractères alpanumériques',
		user_password => 'Not Blank',
		user_role => 'Not balnk',
		user_name => 'Not balnk',
		user_lastname => 'Not balnk',
		user_mail => 'Not blank',
		user_phone => 'Not balnk',
            }
	    
        },
    };
    
    $c->stash->{dfv_profile} = $profile;
}
=head2
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

sub edit  :Chained('user') :PathPart('edit') :Args(0) {
	my ( $self, $c ) = @_;

    return $self->form($c, $c->stash->{user});
}

sub delete :Chained('user') :PathPart('delete') :Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{user}->delete;

	$c->stash->{status_msg} = "User deleted";

	$c->forward('list');
}

=cut


=encoding utf8

=head1 AUTHOR

hoel,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
