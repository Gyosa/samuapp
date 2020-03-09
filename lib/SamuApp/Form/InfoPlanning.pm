package SamuApp::Form::InfoPlanning;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => (default =>'Infoplanning');
has_field 'Nombre de Jour' => (accessor => 'infoplanning_souhait_jour');
has_field 'Nombre de Nuit' => (accessor => 'infoplanning_souhait_nuit');
has_field 'Submit' => (type => 'Submit', value => 'Submit');

__PACKAGE__->meta->make_immutable;
1;
