package Koha::Contrib::Tamil::Sitemaper;
{
  $Koha::Contrib::Tamil::Sitemaper::VERSION = '0.013';
}
# ABSTRACT: Class building Sitemap files for a Koha DB

use Moose;

extends 'Koha::Contrib::Tamil::FileProcess';

use Koha::Contrib::Tamil::Koha;
use Koha::Contrib::Tamil::Sitemaper::Writer;
use Locale::TextDomain 'Koha-Contrib-Tamil';


has koha => (
    is       => 'rw',
    isa      => 'Koha::Contrib::Tamil::Koha',
    required => 0,
);

has url => ( is => 'rw', isa => 'Str' );

has verbose => ( is => 'rw', isa => 'Bool', default => 0 );

has sth => ( is => 'rw' );

has writer => ( is => 'rw', isa => 'Koha::Contrib::Tamil::Sitemaper::Writer' );



before 'run' => sub {
    my $self = shift;

    $self->koha( Koha::Contrib::Tamil::Koha->new() ) unless $self->koha;
    $self->writer(
        Koha::Contrib::Tamil::Sitemaper::Writer->new( url => $self->url ) );

    my $sth = $self->koha->dbh->prepare(
         "SELECT biblionumber, timestamp FROM biblio" );
    $sth->execute();
    $self->sth( $sth );
};


override 'process' => sub {
    my $self = shift;

    my ($biblionumber, $timestamp) = $self->sth->fetchrow;
    return unless $biblionumber;

    $self->writer->write($biblionumber, $timestamp);
    return super();
};


before 'end_process' => sub { shift->writer->end(); };


override 'start_message' => sub {
    print __"Creation of Sitemap files\n";
};


override 'end_message' => sub {
    my $self = shift;
    print __x("Number of biblio records processed: {biblios}\n" .
              "Number of Sitemap files:            {files}\n",
              biblios => $self->count,
              files => $self->writer->count );
};


no Moose;
__PACKAGE__->meta->make_immutable;



=pod

=encoding UTF-8

=head1 NAME

Koha::Contrib::Tamil::Sitemaper - Class building Sitemap files for a Koha DB

=head1 VERSION

version 0.013

=HEAD1 SYNOPSIS

 my $task = Koha::Contrib::Tamil->new( 
    url => 'http://opac.mylibrary.org',
    verbose => 1 );
 $task->run();

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut


__END__

1;

