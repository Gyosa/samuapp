use utf8;
package SamuApp::Schema::Result::Appartient;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Appartient

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

=head1 TABLE: C<appartient>

=cut

__PACKAGE__->table("appartient");

=head1 ACCESSORS

=head2 appartient_utilisateur_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 appartient_groups_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "appartient_utilisateur_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "appartient_groups_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</appartient_utilisateur_id>

=item * L</appartient_groups_id>

=back

=cut

__PACKAGE__->set_primary_key("appartient_utilisateur_id", "appartient_groups_id");

=head1 RELATIONS

=head2 appartient_group

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "appartient_group",
  "SamuApp::Schema::Result::Group",
  { groups_id => "appartient_groups_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 appartient_utilisateur

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Utilisateur>

=cut

__PACKAGE__->belongs_to(
  "appartient_utilisateur",
  "SamuApp::Schema::Result::Utilisateur",
  { utilisateur_id => "appartient_utilisateur_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-04-12 16:31:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1BHLx2enThB8qUbgH8oTCg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
