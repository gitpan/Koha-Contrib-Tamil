package Koha::Contrib::Tamil::RecordWriter;
{
  $Koha::Contrib::Tamil::RecordWriter::VERSION = '0.006';
}
#ABSTRACT: RecordWriter - Base class for writing whatever records into whatever

use Moose;


has count => (
    is => 'rw',
    isa => 'Int',
    default => 0
);


sub begin { }

sub end { }

sub write {
    my $self = shift;

    $self->count( $self->count + 1 );
    
    return 0;
}

__PACKAGE__->meta->make_immutable;

1;



=pod

=encoding UTF-8

=head1 NAME

Koha::Contrib::Tamil::RecordWriter - RecordWriter - Base class for writing whatever records into whatever

=head1 VERSION

version 0.006

=head1 DESCRIPTION

=head1 METHODS

=head2 begin

=head2 end

=head2 write

=head1 SEE ALSO

=over 4

=item *

L<Koha::Contrib::Tamil::RecordWriter>

=item *

L<Koha::Contrib::Tamil::RecordReader>

=back

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut


__END__


