use utf8;
package SamuApp::Schema::Result::Remplicreneau;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Remplicreneau

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

=head1 TABLE: C<remplicreneau>

=cut

__PACKAGE__->table("remplicreneau");

=head1 ACCESSORS

=head2 remplicreneau_utilisateur_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 remplicreneau_creneau_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "remplicreneau_utilisateur_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "remplicreneau_creneau_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</remplicreneau_utilisateur_id>

=item * L</remplicreneau_creneau_id>

=back

=cut

__PACKAGE__->set_primary_key("remplicreneau_utilisateur_id", "remplicreneau_creneau_id");

=head1 RELATIONS

=head2 remplicreneau_creneau

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Creneau>

=cut

__PACKAGE__->belongs_to(
  "remplicreneau_creneau",
  "SamuApp::Schema::Result::Creneau",
  { creneau_id => "remplicreneau_creneau_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 remplicreneau_utilisateur

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Utilisateur>

=cut

__PACKAGE__->belongs_to(
  "remplicreneau_utilisateur",
  "SamuApp::Schema::Result::Utilisateur",
  { utilisateur_id => "remplicreneau_utilisateur_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-04-12 16:31:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nc8bQTMLqhN82ly094EYxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
