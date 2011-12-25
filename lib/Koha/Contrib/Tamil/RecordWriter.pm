package Koha::Contrib::Tamil::RecordWriter;
{
  $Koha::Contrib::Tamil::RecordWriter::VERSION = '0.001';
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

=head1 NAME

Koha::Contrib::Tamil::RecordWriter - RecordWriter - Base class for writing whatever records into whatever

=head1 VERSION

version 0.001

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

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


