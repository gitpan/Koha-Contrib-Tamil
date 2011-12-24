package Koha::Contrib::Tamil::RecordWriter::File;
{
  $Koha::Contrib::Tamil::RecordWriter::File::VERSION = '0.001'; # TRIAL
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

=head1 NAME

Koha::Contrib::Tamil::RecordWriter::File - Records writer into a file base class

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

