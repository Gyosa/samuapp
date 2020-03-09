use utf8;
package SamuApp::Schema::Result::Planning;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Planning

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

=head1 TABLE: C<planning>

=cut

__PACKAGE__->table("planning");

=head1 ACCESSORS

=head2 planning_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'planning_planning_id_seq'

=head2 planning_type

  data_type: 'enum'
  extra: {custom_type_name => "planning_type",list => ["regulateur","mobile","mmg"]}
  is_nullable: 0

=head2 planning_start_date

  data_type: 'date'
  is_nullable: 0

=head2 planning_end_date

  data_type: 'date'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "planning_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "planning_planning_id_seq",
  },
  "planning_type",
  {
    data_type => "enum",
    extra => {
      custom_type_name => "planning_type",
      list => ["regulateur", "mobile", "mmg"],
    },
    is_nullable => 0,
  },
  "planning_start_date",
  { data_type => "date", is_nullable => 0 },
  "planning_end_date",
  { data_type => "date", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</planning_id>

=back

=cut

__PACKAGE__->set_primary_key("planning_id");

=head1 RELATIONS

=head2 creneaus

Type: has_many

Related object: L<SamuApp::Schema::Result::Creneau>

=cut

__PACKAGE__->has_many(
  "creneaus",
  "SamuApp::Schema::Result::Creneau",
  { "foreign.creneau_planning_id" => "self.planning_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 infoplannings

Type: has_many

Related object: L<SamuApp::Schema::Result::Infoplanning>

=cut

__PACKAGE__->has_many(
  "infoplannings",
  "SamuApp::Schema::Result::Infoplanning",
  { "foreign.infoplanning_planning_id" => "self.planning_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 participeplannings

Type: has_many

Related object: L<SamuApp::Schema::Result::Participeplanning>

=cut

__PACKAGE__->has_many(
  "participeplannings",
  "SamuApp::Schema::Result::Participeplanning",
  { "foreign.participeplanning_planning_id" => "self.planning_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 participeplanning_utilisateurs

Type: many_to_many

Composing rels: L</participeplannings> -> participeplanning_utilisateur

=cut

__PACKAGE__->many_to_many(
  "participeplanning_utilisateurs",
  "participeplannings",
  "participeplanning_utilisateur",
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-02-17 13:29:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YwLrFg615IDF734XCZj9mw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
