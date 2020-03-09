use utf8;
package SamuApp::Schema::Result::Creneau;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Creneau

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

=head1 TABLE: C<creneau>

=cut

__PACKAGE__->table("creneau");

=head1 ACCESSORS

=head2 creneau_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'creneau_creneau_id_seq'

=head2 creneau_planning_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 creneau_type

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 creneau_start_datetime

  data_type: 'timestamp'
  is_nullable: 0

=head2 creneau_end_datetime

  data_type: 'timestamp'
  is_nullable: 0

=head2 creneau_nbpersonnes

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "creneau_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "creneau_creneau_id_seq",
  },
  "creneau_planning_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "creneau_type",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "creneau_start_datetime",
  { data_type => "timestamp", is_nullable => 0 },
  "creneau_end_datetime",
  { data_type => "timestamp", is_nullable => 0 },
  "creneau_nbpersonnes",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</creneau_id>

=back

=cut

__PACKAGE__->set_primary_key("creneau_id");

=head1 RELATIONS

=head2 creneau_planning

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Planning>

=cut

__PACKAGE__->belongs_to(
  "creneau_planning",
  "SamuApp::Schema::Result::Planning",
  { planning_id => "creneau_planning_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 remplicreneaus

Type: has_many

Related object: L<SamuApp::Schema::Result::Remplicreneau>

=cut

__PACKAGE__->has_many(
  "remplicreneaus",
  "SamuApp::Schema::Result::Remplicreneau",
  { "foreign.remplicreneau_creneau_id" => "self.creneau_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 remplicreneau_utilisateurs

Type: many_to_many

Composing rels: L</remplicreneaus> -> remplicreneau_utilisateur

=cut

__PACKAGE__->many_to_many(
  "remplicreneau_utilisateurs",
  "remplicreneaus",
  "remplicreneau_utilisateur",
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-02-17 13:29:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gjuyOj0CH1dopRFcu0eavQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
