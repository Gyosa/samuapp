package Object::Solution;

#use namespace::autoclean;
use strict;
use warnings;

sub new{
    my ($class, $args) = @_;
    my $self = bless {}, $class;
}

## Getter as Setter ##
sub get_users($){
    my ($self, $creneau_id) = @_;
    # test if  $self->{$creneau_id}  exist
    return @{ $self->{$creneau_id} };
}

## Methods ##
sub add($$){
    my ($self, $creneau_id, $user_id) = @_;
    $self->{$creneau_id} //= [];
    push(@{ $self->{$creneau_id} }, $user_id);
}
1;
