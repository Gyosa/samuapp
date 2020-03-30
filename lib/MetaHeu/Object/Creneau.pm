package Object::Creneau;

#use namespace::autoclean;
use strict;
use warnings;


sub new {
	my ($class, $args) = @_;
	my $self = bless {creneau_id => $args->{creneau_id},
					  nb_personnes => $args->{nb_personnes},
					  start_datetime => $args->{start_datetime},
					  end_datetime => $args->{end_datetime}
					  
	},$class;
}

# get name of the user
sub get_creneau_id{
   my $self = shift;
   return $self->{creneau_id};
}
 
# set new creneau_id for the user
sub set_creneau_id{
   my ($self,$new_creneau_id) = @_;
   $self->{creneau_id} = $new_creneau_id;
}
 

# get nb_personnes
sub get_nb_personnes{
   my $self = shift;
   return $self->{nb_personnes};   
}
# set nb_personnes
sub set_nb_personnes{
   my ($self,$new_nb_personnes) = @_;
   $self->{nb_personnes} = $new_nb_personnes;
}

# get start_datetime of the user
sub get_start_datetime{
   my $self = shift;
   return $self->{start_datetime};
}
 
# set end_datetime for the user
sub set_start_datetime{
   my ($self,$new_start_datetime) = @_;
   $self->{start_datetime} = $new_start_datetime;
}
# get end_datetime of the user
sub get_end_datetime{
   my $self = shift;
   return $self->{end_datetime};
}
 
# set end_datetime for the user
sub set_end_datetime{
   my ($self,$new_end_datetime) = @_;
   $self->{end_datetime} = $new_end_datetime;
}

1;