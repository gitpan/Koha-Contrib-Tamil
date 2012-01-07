package Koha::Contrib::Tamil::Conversion;
{
  $Koha::Contrib::Tamil::Conversion::VERSION = '0.007';
}
# ABSTRACT: Base class for conversion type subclasses

use Moose;

use Koha::Contrib::Tamil::Converter;

extends 'Koha::Contrib::Tamil::FileProcess';


# Le lecteur d'enregistrements utilisé par la conversion
has reader => (
    is => 'rw', 
    #isa => 'RecordReader',
);

# Le writer dans lequel écrie les enregistremens convertis
has writer => ( 
    is => 'rw',
    #isa => 'RecordWriter',
);

# Le converter qui transforme les notices en notices MARC
has converter => ( isa => 'Koha::Contrib::Tamil::Converter', is => 'rw' );



sub run  {
    my $self = shift;
    $self->writer->begin();
    $self->SUPER::run();
};


sub process {
    my $self = shift;
    my $record = $self->reader->read();
    if ( $record ) {
        $self->SUPER::process();
        my $converter = $self->converter;
        my $converted_record = 
            $converter ? $converter->convert( $record ) : $record;
        unless ( $converted_record ) {
            # Conversion échouée mais il reste des enregistrements
            # print "NOTICE NON CONVERTIE #", $self->count(), "\n";
            return 1;
        }
        $self->writer->write( $converted_record );
        return 1;
    }
    $self->writer->end();
    return 0;
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;


__END__
=pod

=encoding UTF-8

=head1 NAME

Koha::Contrib::Tamil::Conversion - Base class for conversion type subclasses

=head1 VERSION

version 0.007

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut

