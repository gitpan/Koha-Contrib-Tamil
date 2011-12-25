package Koha::Contrib::Tamil::Authority::Task;
{
  $Koha::Contrib::Tamil::Authority::Task::VERSION = '0.001';
}
# ABSTRACT: Base class for managing authorities manipulations
use Moose;

extends 'Koha::Contrib::Tamil::FileProcess';

use Carp;
use YAML::Syck;

has conf_authorities => ( is => 'rw', isa => 'ArrayRef' );

has conf_file => (
    is => 'rw',
    isa => 'Str',
    trigger => sub {
        my ($self, $file) = @_;
        unless ( -e $file ) {
            croak "File doesn't exist: " . $file;
        }
        my @authorities = LoadFile( $file ) or croak "Load conf auth impossible";
        $self->conf_authorities( \@authorities );
    }
);


no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__
=pod

=head1 NAME

Koha::Contrib::Tamil::Authority::Task - Base class for managing authorities manipulations

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

