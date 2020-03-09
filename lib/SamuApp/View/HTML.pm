package SamuApp::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,

	INCLUDE_PATH => [
		SamuApp->path_to( 'root','src' ),
	],
	# Set to 1 for detailled timer stats in your HTML as comments
	TIMER => 0,
	WRAPPER => 'wrapper.tt2',

);

=head1 NAME

SamuApp::View::HTML - TT View for SamuApp

=head1 DESCRIPTION

TT View for SamuApp.

=head1 SEE ALSO

L<SamuApp>

=head1 AUTHOR

hoel,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
