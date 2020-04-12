package Object::Config;

#use namespace::autoclean;
use strict;
use warnings;


sub new {
	my ($class, $args) = @_;
	my $self = bless {creneaux => $args->{creneaux},
			  users => $args->{users},
			  start_date => $args->{start_date},
			  end_date => $args->{end_date}
					  
	},$class;
}

sub get_creneaux{
	my $self = shift;
	return $self->{creneaux};
}
sub set_creneaux{
	my ($self, $new_creneaux) = @_;
    $self->{user} = $new_creneaux;
}
sub get_creneau($){
	my ($self, $id) = @_;
	for my $creneau ($self->{creneaux}->get_creneaux){
		if ($id == $creneau->get_creneau_id()) {
			return $creneau;
		}
	}
	return -2;
}

sub get_users{
	my $self = shift;
	return $self->{users};
}
sub set_users{
	my ($self, $new_users) = @_;
    $self->{user} = $new_users;
}
sub get_user($){
	my ($self, $id) = @_;
	for my $user ($self->{users}->get_users){
		if ($id == $user->get_user_id()) {
			return $user;
		}
	}
	return -1;
}

sub get_start_date {
    my $self = shift;
    return $self->{start_date};
}
sub get_end_date {
    my $self = shift;
    return $self->{end_date};
}
1;
