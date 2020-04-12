package SamuApp::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'SamuApp::Schema',
    
    connect_info => {
        dsn => 'dbi:Pg:dbname=samuapp',
        user => 'catalyst',
        password => 'catalyst',
        AutoCommit => q{1},
    }
);

=head1 NAME

SamuApp::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<SamuApp>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<SamuApp::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Hoeël

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
