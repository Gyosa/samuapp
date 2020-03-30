package Mmas::Pheromone;
use strict;
use warnings;

use Data::Dumper;

sub new {
    my ($class, $args) = @_;
    my $self = { n_col => $args->{n_col},
		 n_row => $args->{n_row},
		 matrix => $args->{matrix}
    };
    if (! defined $self->{matrix}){
	#push @{ $self->{matrix} }, [(1) x $self->{n_row}] for (1..$self->{n_col});
    }
    # else test $self->{matrix} format and check n_col and n_row 
    bless($self, $class);
}

## Getter and Setter ##

sub get_n_col {
    my $self = shift;
    return $self->{n_col};
}

sub get_n_row {
    my $self = shift;
    return $self->{n_row};
}

sub get_matrix {
    my $self = shift;
    return $self->{matrix};
}

sub get_val ($$) {
    my ($self, $col, $row) = @_;
    return $self->{matrix}->{$col}->{$row};
}

sub set_val ($$$) {
    my ($self, $col, $row, $val) = @_;
    $self->{matrix}->{$col}->{$row} = $val;
}
## Methods ##
sub initialize {
    my ($self, $config, $val) = @_;
    my $creneaux = $config->{creneaux};
    my $users = $config->{users};
    for my $creneau ($creneaux->get_creneaux()) {
	for my $user ($users->get_users()) {
	    $self->{matrix}->{$creneau->get_creneau_id()}->{$user->get_user_id()} = $val;
	}
    }
    
}

1;
