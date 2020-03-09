package SamuApp::Form::Users;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => (default =>'Utilisateur');
has_field 'Authentifiant' => (accessor => 'utilisateur_auth');
has_field 'Password' => (accessor => 'utilisateur_password');
has_field 'Rôle de l\'utilisateur' => (accessor =>'utilisateur_role');
has_field 'Prénom de l\'utilisateur' => (accessor => 'utilisateur_prenom');
has_field 'Nom de l\'utilisateur' => (accessor => 'utilisateur_nom');
has_field 'Mail' => (accessor => 'utilisateur_mail');
has_field 'Téléphone' => (accessor => 'utilisateur_phone');
has_field 'Submit' => (type => 'Submit', value => 'Submit');

__PACKAGE__->meta->make_immutable;
1;
