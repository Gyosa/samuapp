package SamuApp::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SamuApp::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
# Get the username and password from form
    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};
 
    # If the username and password values were found in form
    if ($username && $password) {
        # Attempt to log the user in
        if ($c->authenticate({ utilisateur_auth => $username,
                               utilisateur_password => $password  } )) {
			     #utilisateur_password => $password
            # If successful, then let them use the application
			if ($c->user->utilisateur_role eq "admin"){
				
				$c->response->redirect($c->uri_for($c->controller('Admin::Users')->action_for('list')));
				return;
			}else{
				$c->response->redirect($c->uri_for($c->controller('User')->action_for('info')));
				return;
			}
        } else {
            # Set an error message
            $c->stash(error_msg => "Bad username or password.");
        }
    } else {
        # Set an error message
        $c->stash(error_msg => "Empty username or password.")
            unless ($c->user_exists);
    }
 
    # If either of above don't work out, send to the login page
    $c->stash(template => 'login/login.tt2');
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
