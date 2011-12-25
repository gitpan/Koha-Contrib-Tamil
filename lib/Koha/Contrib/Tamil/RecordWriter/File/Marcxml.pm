package Koha::Contrib::Tamil::RecordWriter::File::Marcxml;
{
  $Koha::Contrib::Tamil::RecordWriter::File::Marcxml::VERSION = '0.001';
}
# ABSTRACT: XML MARC record reader
use Moose;

extends 'Koha::Contrib::Tamil::RecordWriter::File';

use Carp;
use MARC::Batch;
use MARC::Record;
use MARC::File::XML;


# Is XML Stream a valid marxml
# By default no => no <collection> </collection>
has valid => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);


sub BUILD {
    my $self = shift;
    if ( $self->valid ) {
        my $fh = $self->fh;
        print $fh '<collection>', "\n";
    }
}


sub DEMOLISH {
    my $self = shift;
    if ( $self->valid ) {
        my $fh = $self->fh;
        print $fh '</collection>', "\n";
    }
}



#
# Sent record is rather a MARC::Record object or an marcxml string
#
sub write {
    my ( $self, $record ) = @_;

    $self->SUPER::write();

    my $fh  = $self->fh;
    my $xml = ref($record) eq 'MARC::Record'
              ? $record->as_xml_record() : $record;
    $xml =~ s/<\?xml version="1.0" encoding="UTF-8"\?>\n//g if $self->valid;
    print $fh $xml;
}

__PACKAGE__->meta->make_immutable;

1;

__END__
=pod

=head1 NAME

Koha::Contrib::Tamil::RecordWriter::File::Marcxml - XML MARC record reader

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

