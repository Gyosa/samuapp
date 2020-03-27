package Object::ListUser;

#use namespace::autoclean;
use strict;
use warnings;


sub new {
    my ($class, $args) = @_;
    my $self =  {nb_users => $args->{nb_users},
		 users  => $args->{users}
    };
    #$self->set_nb_users;
    $self->{users} //= [];
    $self->{nb_users} = scalar(@{ $self->{users} });
    bless($self, $class);
}

# get nb_users of the user
sub get_nb_users{
    my $self = shift;
    $self->set_nb_users();
    return $self->{nb_users};
}

# set nb_users for the user
sub set_nb_users{
    my $self = shift;
    #my $temp = $self->get_users;
    $self->{nb_users} = scalar(@{ $self->{users} });
}

sub get_users{
    my $self = shift;
    my $temp = $self->{users};
    my @ret = @$temp;
    return @ret;
}
sub set_users{
    my ($self, $new_users) = @_;
    # $new_users is a ARRAY REF of User
    $self->{users} = @$new_users;
}
sub get_user($){
    my ($self, $id) = @_;
    for my $user ($self->get_users){
	if ($id == $user->get_user_id()) {
	    return $user;
	}
    }
    return -1;
}
sub add_user($){
    my ($self, $user) = @_;
    # need to test user
    push(@{ $self->{users} }, $user);
    $self->set_nb_users;
}
1;
