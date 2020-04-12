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
    if (defined $self->{$creneau_id} ) {
	return @{ $self->{$creneau_id} };
    }
    return ();
}

sub get_creneaux {
    my $self = shift;
    #return sort(keys(%{ $self }));
    return keys( %{ $self } );
}

## Methods ##
sub add($$){
    my ($self, $creneau_id, $user_id) = @_;
    $self->{$creneau_id} //= [];
    push(@{ $self->{$creneau_id} }, $user_id);
}

sub ordened_cren {
    my $self = shift;
    return sort($self->get_creneaux());
}

sub cren_user($){
    my ($self, $user_id) = @_;

    my @list_id;
    for my $creneau_id ($self->get_creneaux()){	    
	    my %hash = map {$_ => 1} $self->get_users($creneau_id);
	    if ( exists( $hash{$user_id} ) ) {
		push(@list_id,$creneau_id);
	    }
	    
    }
    return sort(@list_id);
}

sub nb_cren_user($) {
    my ($self, $user_id) = @_;

    my $nb = 0;
    for my $creneau_id ($self->get_creneaux()){	    
	    my %hash = map {$_ => 1} $self->get_users($creneau_id);
	    $nb += ( exists( $hash{$user_id} ) ); 
	    
    }
    return $nb;
    
}

# output methods
sub print {
    my $self = shift;
    for my $cren_id ( $self->ordened_cren() ){
	printf("Creneau ID:%4d => ".'%4d ' x scalar($self->get_users($cren_id))."\n", $cren_id, $self->get_users($cren_id));
    }
}
1;
