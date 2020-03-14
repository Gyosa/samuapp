package Object::ListCreneau;

#use namespace::autoclean;
use strict;
use warnings;


sub new {
	my ($class, $args) = @_;
	my $self =  {nb_creneaux => $args->{nb_creneaux},
					  creneaux  => $args->{creneaux}
	};
	#$self->set_nb_creneaux;
	$self->{creneaux} //= []; 
	bless($self, $class);
}

# get nb_creneaux of the user
sub get_nb_creneaux{
	my $self = shift;
	$self->set_nb_creneaux();
    return $self->{nb_creneaux};
}
 
# set nb_creneaux for the user
sub set_nb_creneaux{
	my $self = shift;
	#my $temp = $self->get_creneaux;
    $self->{nb_creneaux} = scalar($self->get_creneaux);
}

sub get_creneaux{
	my $self = shift;
	my $temp = $self->{creneaux};
	my @ret = @$temp;
	return @ret;
}
sub set_creneaux{
	my ($self, $new_creneaux) = @_;
    $self->{user} = $new_creneaux;
}
sub get_creneau($){
	my ($self, $id) = @_;
	for my $creneau ($self->get_creneaux){
		if ($id == $creneau->get_creneau_id()) {
			return $creneau;
		}
	}
	return -1;
}
1;
