use utf8;
package SamuApp::Schema::Result::Infoplanning;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Infoplanning

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

=head1 TABLE: C<infoplanning>

=cut

__PACKAGE__->table("infoplanning");

=head1 ACCESSORS

=head2 infoplanning_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'infoplanning_infoplanning_id_seq'

=head2 infoplanning_utilisateur_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 infoplanning_planning_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 infoplanning_souhait_jour

  data_type: 'integer'
  is_nullable: 1

=head2 infoplanning_souhait_nuit

  data_type: 'integer'
  is_nullable: 1

=head2 infoplanning_souhait_soiree

  data_type: 'integer'
  is_nullable: 1

=head2 infoplanning_souhait_nuitcourte

  data_type: 'integer'
  is_nullable: 1

=head2 infoplanning_start_vacances

  data_type: 'date'
  is_nullable: 1

=head2 infoplanning_end_vacances

  data_type: 'date'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "infoplanning_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "infoplanning_infoplanning_id_seq",
  },
  "infoplanning_utilisateur_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "infoplanning_planning_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "infoplanning_souhait_jour",
  { data_type => "integer", is_nullable => 1 },
  "infoplanning_souhait_nuit",
  { data_type => "integer", is_nullable => 1 },
  "infoplanning_souhait_soiree",
  { data_type => "integer", is_nullable => 1 },
  "infoplanning_souhait_nuitcourte",
  { data_type => "integer", is_nullable => 1 },
  "infoplanning_start_vacances",
  { data_type => "date", is_nullable => 1 },
  "infoplanning_end_vacances",
  { data_type => "date", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</infoplanning_id>

=back

=cut

__PACKAGE__->set_primary_key("infoplanning_id");

=head1 RELATIONS

=head2 infoplanning_planning

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Planning>

=cut

__PACKAGE__->belongs_to(
  "infoplanning_planning",
  "SamuApp::Schema::Result::Planning",
  { planning_id => "infoplanning_planning_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 infoplanning_utilisateur

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Utilisateur>

=cut

__PACKAGE__->belongs_to(
  "infoplanning_utilisateur",
  "SamuApp::Schema::Result::Utilisateur",
  { utilisateur_id => "infoplanning_utilisateur_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 vacances

Type: has_many

Related object: L<SamuApp::Schema::Result::Vacance>

=cut

__PACKAGE__->has_many(
  "vacances",
  "SamuApp::Schema::Result::Vacance",
  { "foreign.vacance_infoplanning_id" => "self.infoplanning_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-04-12 16:31:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AfD4je1poPSsOoxa/UHIrg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
