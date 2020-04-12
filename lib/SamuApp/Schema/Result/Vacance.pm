use utf8;
package SamuApp::Schema::Result::Vacance;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

SamuApp::Schema::Result::Vacance

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

=head1 TABLE: C<vacance>

=cut

__PACKAGE__->table("vacance");

=head1 ACCESSORS

=head2 vacance_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'vacance_vacance_id_seq'

=head2 vacance_infoplanning_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 vacance_start_date

  data_type: 'date'
  is_nullable: 0

=head2 vacance_end_date

  data_type: 'date'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "vacance_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "vacance_vacance_id_seq",
  },
  "vacance_infoplanning_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "vacance_start_date",
  { data_type => "date", is_nullable => 0 },
  "vacance_end_date",
  { data_type => "date", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</vacance_id>

=back

=cut

__PACKAGE__->set_primary_key("vacance_id");

=head1 RELATIONS

=head2 vacance_infoplanning

Type: belongs_to

Related object: L<SamuApp::Schema::Result::Infoplanning>

=cut

__PACKAGE__->belongs_to(
  "vacance_infoplanning",
  "SamuApp::Schema::Result::Infoplanning",
  { infoplanning_id => "vacance_infoplanning_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2020-04-12 16:31:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2BnAXnfbpzmU19w/Mez8Nw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
