package SamuApp::Model::File;

use strict;
use base 'Catalyst::Model::File';

__PACKAGE__->config(
    root_dir => '/var/local/samuapp',
);

=head1 NAME

SamuApp::Model::File - Catalyst File Model

=head1 SYNOPSIS

See L<SamuApp>

=head1 DESCRIPTION

L<Catalyst::Model::File> Model storing files under
L<>

=head1 AUTHOR

hoel,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
