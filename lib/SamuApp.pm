package SamuApp;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple

    StatusMessage

    Authentication

    Session
    Session::State::Cookie
    Session::Store::File

    ConfigLoader
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in samuapp.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'SamuApp',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
);

__PACKAGE__->config(
	'View::HTML' => {
		INCLUDE_PATH => [
			__PACKAGE__->path_to( 'root','src' ),
		],
	},
);
### test file permission denied ###
#__PACKAGE__->config(
#	'Plugin::ConfigLoader' => { file => 'root/src/planning/planning_create.xml' } 
#);
#SamuApp->config(
#    name          => 'SamuApp',
#    root          => SamuApp->path_to('root'),
#    'Model::File' => {
#        root_dir => SamuApp->path_to('home/hoel/Documents/samuApp/catalyst/samuFiles')
#    },
#);

# config status message
__PACKAGE__->config(
    'Plugin::StatusMessage' => {
		session_prefix => 'my_status_msg',
        token_param => 'my_mid',
        status_msg_stash_key => 'my_status_msg',
        error_msg_stash_key => 'my_error_msg',
    }
);
#config Authentication
__PACKAGE__->config('Plugin::Authentication' => {
    default_realm => 'members',
    realms => {
        members => {
            credential => {
                class => 'Password',
                password_field => 'utilisateur_password',
                password_type => 'self_check'
            },
            store => {
                class => 'DBIx::Class',
                user_model => 'DB::Utilisateur',
            }
        }
    }
});
=head
__PACKAGE__->config(
	'Plugin::Authentication' => {
		default  => {
			credential => {
				
				class => 'SimpleDB',
				user_model => 'DB::Utilisateur',
				password_type => 'self_check',
		},
	},
);
=cut


#config session
__PACKAGE__->config(
	'Plugin::Session' => {
		expires => 3600,
		rewrite => 0,
		storage => '/tmp/cata_session'
	}
	);
	

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

SamuApp - Catalyst based application

=head1 SYNOPSIS

    script/samuapp_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<SamuApp::Controller::Root>, L<Catalyst>

=head1 AUTHOR

hoel,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
