use utf8;
package SamuApp::Schema::Result::Participeplanning;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Participeplanning

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

=head1 TABLE: C<participeplanning>

=cut

__PACKAGE__->table("participeplanning");

=head1 ACCESSORS

=head2 participeplanning_utilisateur_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 participeplanning_planning_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "participeplanning_utilisateur_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "participeplanning_planning_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</participeplanning_utilisateur_id>

=item * L</participeplanning_planning_id>

=back

=cut

__PACKAGE__->set_primary_key(
  "participeplanning_utilisateur_id",
  "participeplanning_planning_id",
);

=head1 RELATIONS

=head2 participeplanning_planning

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Planning>

=cut

__PACKAGE__->belongs_to(
  "participeplanning_planning",
  "SamuApp::Schema::Result::Planning",
  { planning_id => "participeplanning_planning_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 participeplanning_utilisateur

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Utilisateur>

=cut

__PACKAGE__->belongs_to(
  "participeplanning_utilisateur",
  "SamuApp::Schema::Result::Utilisateur",
  { utilisateur_id => "participeplanning_utilisateur_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-02-17 13:29:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QMiOCIE4jfQic4LSv3IKsw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
