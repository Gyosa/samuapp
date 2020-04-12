use utf8;
package SamuApp::Schema::Result::Utilisateur;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Utilisateur

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

=head1 TABLE: C<utilisateur>

=cut

__PACKAGE__->table("utilisateur");

=head1 ACCESSORS

=head2 utilisateur_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'utilisateur_utilisateur_id_seq'

=head2 utilisateur_role

  data_type: 'enum'
  extra: {custom_type_name => "user_role",list => ["admin","user"]}
  is_nullable: 0

=head2 utilisateur_auth

  data_type: 'text'
  is_nullable: 0

=head2 utilisateur_password

  data_type: 'text'
  is_nullable: 0

=head2 utilisateur_nom

  data_type: 'varchar'
  is_nullable: 0
  size: 60

=head2 utilisateur_prenom

  data_type: 'varchar'
  is_nullable: 0
  size: 60

=head2 utilisateur_mail

  data_type: 'varchar'
  is_nullable: 1
  size: 60

=head2 utilisateur_phone

  data_type: 'varchar'
  is_nullable: 1
  size: 60

=cut

__PACKAGE__->add_columns(
  "utilisateur_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "utilisateur_utilisateur_id_seq",
  },
  "utilisateur_role",
  {
    data_type => "enum",
    extra => { custom_type_name => "user_role", list => ["admin", "user"] },
    is_nullable => 0,
  },
  "utilisateur_auth",
  { data_type => "text", is_nullable => 0 },
  "utilisateur_password",
  { data_type => "text", is_nullable => 0 },
  "utilisateur_nom",
  { data_type => "varchar", is_nullable => 0, size => 60 },
  "utilisateur_prenom",
  { data_type => "varchar", is_nullable => 0, size => 60 },
  "utilisateur_mail",
  { data_type => "varchar", is_nullable => 1, size => 60 },
  "utilisateur_phone",
  { data_type => "varchar", is_nullable => 1, size => 60 },
);

=head1 PRIMARY KEY

=over 4

=item * L</utilisateur_id>

=back

=cut

__PACKAGE__->set_primary_key("utilisateur_id");

=head1 RELATIONS

=head2 appartients

Type: has_many

Related object: L<SamuApp::Schema::Result::Appartient>

=cut

__PACKAGE__->has_many(
  "appartients",
  "SamuApp::Schema::Result::Appartient",
  { "foreign.appartient_utilisateur_id" => "self.utilisateur_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 infoplannings

Type: has_many

Related object: L<SamuApp::Schema::Result::Infoplanning>

=cut

__PACKAGE__->has_many(
  "infoplannings",
  "SamuApp::Schema::Result::Infoplanning",
  { "foreign.infoplanning_utilisateur_id" => "self.utilisateur_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 participeplannings

Type: has_many

Related object: L<SamuApp::Schema::Result::Participeplanning>

=cut

__PACKAGE__->has_many(
  "participeplannings",
  "SamuApp::Schema::Result::Participeplanning",
  {
    "foreign.participeplanning_utilisateur_id" => "self.utilisateur_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 remplicreneaus

Type: has_many

Related object: L<SamuApp::Schema::Result::Remplicreneau>

=cut

__PACKAGE__->has_many(
  "remplicreneaus",
  "SamuApp::Schema::Result::Remplicreneau",
  { "foreign.remplicreneau_utilisateur_id" => "self.utilisateur_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 appartient_groups

Type: many_to_many

Composing rels: L</appartients> -> appartient_group

=cut

__PACKAGE__->many_to_many("appartient_groups", "appartients", "appartient_group");

=head2 participeplanning_plannings

Type: many_to_many

Composing rels: L</participeplannings> -> participeplanning_planning

=cut

__PACKAGE__->many_to_many(
  "participeplanning_plannings",
  "participeplannings",
  "participeplanning_planning",
);

=head2 remplicreneau_creneaus

Type: many_to_many

Composing rels: L</remplicreneaus> -> remplicreneau_creneau

=cut

__PACKAGE__->many_to_many(
  "remplicreneau_creneaus",
  "remplicreneaus",
  "remplicreneau_creneau",
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-04-12 16:31:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TCrKAuh+ZN9R1GpKaPkMIA

# Have the 'password' column use a SHA-1 hash and 20-byte salt
# with RFC 2307 encoding; Generate the 'check_password" method

__PACKAGE__->add_columns(
    'utilisateur_password' => {
        passphrase       => 'rfc2307',
        passphrase_class => 'SaltedDigest',
        passphrase_args  => {
            algorithm   => 'SHA-1',
            salt_random => 20,
        },
        passphrase_check_method => 'check_password',
    },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
