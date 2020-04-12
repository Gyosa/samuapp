use utf8;
package SamuApp::Schema::Result::Group;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Group

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<groups>

=cut

__PACKAGE__->table("groups");

=head1 ACCESSORS

=head2 groups_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'groups_groups_id_seq'

=head2 groups_name

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 groups_description

  data_type: 'varchar'
  is_nullable: 1
  size: 1024

=cut

__PACKAGE__->add_columns(
  "groups_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "groups_groups_id_seq",
  },
  "groups_name",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "groups_description",
  { data_type => "varchar", is_nullable => 1, size => 1024 },
);

=head1 PRIMARY KEY

=over 4

=item * L</groups_id>

=back

=cut

__PACKAGE__->set_primary_key("groups_id");

=head1 RELATIONS

=head2 appartients

Type: has_many

Related object: L<SamuApp::Schema::Result::Appartient>

=cut

__PACKAGE__->has_many(
  "appartients",
  "SamuApp::Schema::Result::Appartient",
  { "foreign.appartient_groups_id" => "self.groups_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 appartient_utilisateurs

Type: many_to_many

Composing rels: L</appartients> -> appartient_utilisateur

=cut

__PACKAGE__->many_to_many(
  "appartient_utilisateurs",
  "appartients",
  "appartient_utilisateur",
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-04-12 16:31:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sDg55YMHcHt8Ij6J/Q3wcQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
