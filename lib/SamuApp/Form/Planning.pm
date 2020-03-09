package SamuApp::Form::Planning;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => (default =>'Planning');
has_field 'Planning Type' => (accessor => 'planning_type');
has_field 'Start Date' => (accessor => 'planning_start_date');
has_field 'End Date' => (accessor =>'planning_end_date');
has_field 'Submit' => (type => 'Submit', value => 'Submit');

__PACKAGE__->meta->make_immutable;
1;
