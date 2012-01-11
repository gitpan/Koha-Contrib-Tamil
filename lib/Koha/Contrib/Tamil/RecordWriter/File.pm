package Koha::Contrib::Tamil::RecordWriter::File;
{
  $Koha::Contrib::Tamil::RecordWriter::File::VERSION = '0.009';
}
#ABSTRACT: Records writer into a file base class

use Moose;

use Carp;
use IO::File;

extends 'Koha::Contrib::Tamil::RecordWriter';

has file => (
    is => 'rw',
    isa => 'Str',
    trigger => sub {
        my ($self, $file) = @_;
        # FIXME: On ne teste pas si le fichier existe déjà.
        # S'il existe, on l'écrase
        #if ( -e $file ) {
        #    croak "File already exist: " . $file;
        #}
        $self->{file} = $file;
        my $fh        = IO::File->new( "> $file" );
        $self->{fh}   = $fh;
        binmode( $fh, $self->binmode ) if $self->binmode;
    }

);

has binmode => (
    is => 'rw',
    isa => 'Str',
);

has fh => ( is => 'rw', isa => 'IO::Handle' );


__PACKAGE__->meta->make_immutable;

1;

__END__
=pod

=encoding UTF-8

=head1 NAME

Koha::Contrib::Tamil::RecordWriter::File - Records writer into a file base class

=head1 VERSION

version 0.009

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut

