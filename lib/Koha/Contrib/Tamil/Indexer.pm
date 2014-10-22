package Koha::Contrib::Tamil::Indexer;
{
  $Koha::Contrib::Tamil::Indexer::VERSION = '0.001';
}
# ABSTRACT: Class doing Zebra Koha indexing

use Moose;

use FindBin qw( $Bin );
use lib "$Bin/../lib";

use Carp;
use Koha::Contrib::Tamil::Koha;
use Koha::Contrib::Tamil::RecordReader;
use Koha::Contrib::Tamil::RecordWriter::File::Marcxml;
use Koha::Contrib::Tamil::Conversion;
use File::Path;
use YAML;
use Locale::TextDomain 'fr.tamil.koha-tools';


with 'MooseX::Getopt';

has koha => (
    is       => 'rw',
    isa      => 'Koha::Contrib::Tamil::Koha',
    required => 0,
    traits  => [ 'NoGetopt' ],
);

has conf => (
    is      => 'rw',
    isa     => 'Str',
    trigger => sub {
        my ( $self, $file ) = @_;
        $self->koha( Koha::Contrib::Tamil::Koha->new( conf_file => $file ) );
        return $file;
    },
);

has source => (
    is      => 'rw',
    isa     => 'Koha::RecordType',
    default => 'biblio'
);

has select => (
    is       => 'rw',
    isa      => 'Koha::RecordSelect',
    required => 1,
    default  => 'all',
);

has directory => (
    is      => 'rw',
    isa     => 'Str',
    default => './koha-index',
);

has verbose => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

has help => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
    traits  => [ 'NoGetopt' ],
);

has blocking => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
    traits  => [ 'NoGetopt' ],
);

sub run {
    my $self = shift;

    # Is it a full indexing of all Koha DB records?
    my $is_full_indexing = $self->select =~ /all/i;

    # Is it biblio indexing (if not it's authority)
    my $is_biblio_indexing = $self->source =~ /biblio/i;

    $self->koha( Koha::Contrib::Tamil::Koha->new() ) unless $self->koha;

    # STEP 1: All biblio records are exported in a directory

    mkdir $self->directory;
    my $from_dir = $self->directory . "/" . $self->source;
    mkdir $from_dir;
    for my $dir ( ( "$from_dir/update", "$from_dir/delete") ) {
        rmtree( $dir ) if -d $dir;
        mkdir $dir;
    }

    # STEP 1.1: Records to update
    print __"Exporting records to update", "\n" if $self->verbose;
    my $exporter = Koha::Contrib::Tamil::Conversion->new(
        reader => Koha::Contrib::Tamil::RecordReader->new(
            koha   => $self->koha,
            source => $self->source,
            select => $is_full_indexing ? 'all' : 'queue_update',
            xml    => '1'
        ),
        writer => Koha::Contrib::Tamil::RecordWriter::File::Marcxml->new(
            file    => "$from_dir/update/records",
            binmode => 'utf8'
        ),
        blocking    => $self->blocking,
        verbose     => $is_full_indexing ? $self->verbose : 0,
    );
    $exporter->run();

    # STEP 1.2: Record to delete, if zebraqueue
    if ( ! $is_full_indexing ) {
        print __"Exporting records to delete", "\n" if $self->verbose;
        $exporter = Koha::Contrib::Tamil::Conversion->new(
            reader => Koha::Contrib::Tamil::RecordReader->new(
                koha   => $self->koha,
                source => $self->source,
                select => 'queue_delete',
                xml    => '1'
            ),
            writer => Koha::Contrib::Tamil::RecordWriter::File::Marcxml->new(
                file    => "$from_dir/delete/records",
                binmode => 'utf8'
            ),
            blocking    => $self->blocking,
        );
        $exporter->run();
    }

    # STEP 2: Run zebraidx

    my $cmd;
    my $zconfig  = $self->koha->conf->{server}->{
       $is_biblio_indexing ? 'biblioserver' : 'authorityserver' }->{config};
    my $db_name  = $is_biblio_indexing ? 'biblios' : 'authorities';
    my $cmd_base = "zebraidx -c " . $zconfig;
    $cmd_base   .= " -n" if $is_full_indexing; # No shadow: no indexing daemon
    $cmd_base   .= $self->verbose ? " -v warning,log" : " -v none";
    $cmd_base   .= " -g marcxml";
    $cmd_base   .= " -d $db_name";

    if ( $is_full_indexing ) {
        $cmd = "$cmd_base init";
        print "$cmd\n" if $self->verbose;
        system( $cmd );
    }

    $cmd = "$cmd_base update $from_dir/update";
    print "$cmd\n" if $self->verbose;
    system( $cmd );

    if ( ! $is_full_indexing ) {
        $cmd = "$cmd_base adelete $from_dir/delete";
        print "$cmd\n" if $self->verbose;
        system( $cmd );
        my $cmd = "$cmd_base commit";
        print "$cmd\n" if $self->verbose;
        system( $cmd );

        # Update zebraqueue
        my $sql = "UPDATE zebraqueue SET done=1 WHERE server = ?";
        my $sth = $self->koha->dbh->prepare( $sql );
        $sth->execute( 
            $self->source =~ /biblio/ ? 'biblioserver' : 'authorityserver' );
    }

}

no Moose;
__PACKAGE__->meta->make_immutable;

1;


__END__
=pod

=head1 NAME

Koha::Contrib::Tamil::Indexer - Class doing Zebra Koha indexing

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

