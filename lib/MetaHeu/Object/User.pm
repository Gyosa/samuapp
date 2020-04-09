package Object::User;

#use namespace::autoclean;
use strict;
use warnings;


sub new{
	my ($class, $args) = @_;
	my $self = bless {user_id => $args->{user_id},
			  souhait_jour => $args->{souhait_jour},
			  souhait_nuit => $args->{souhait_nuit}
	},$class;
}

# get name of the user
sub get_user_id{
   my $self = shift;
   return $self->{user_id};
}
 
# set new user_id for the user
sub set_user_id{
   my ($self,$new_user_id) = @_;
   $self->{user_id} = $new_user_id;
}
 
# get souhait_jour of the user
sub get_souhait_jour{
   my $self = shift;
   return $self->{souhait_jour};
}
 
# set souhait_jour for the user
sub set_souhait_jour{
   my ($self,$new_souhait_jour) = @_;
   $self->{souhait_jour} = $new_souhait_jour;
}
# get souhait_nuit
sub get_souhait_nuit{
   my $self = shift;
   return $self->{souhait_nuit};   
}
# set souhait_nuit
sub set_souhait_nuit{
   my ($self,$new_souhait_nuit) = @_;
   $self->{souhait_nuit} = $new_souhait_nuit;
}

1;
