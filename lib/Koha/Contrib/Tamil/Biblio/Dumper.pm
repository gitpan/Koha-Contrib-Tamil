package Koha::Contrib::Tamil::Biblio::Dumper;
{
  $Koha::Contrib::Tamil::Biblio::Dumper::VERSION = '0.030';
}
# ABSTRACT: Class dumping a Koha Catalog

use Moose;

extends 'AnyEvent::Processor';

use Modern::Perl;
use Koha::Contrib::Tamil::Koha;
use Koha::Contrib::Tamil::Sitemaper::Writer;
use MARC::Moose::Record;
use MARC::Moose::Writer;
use MARC::Moose::Formater::Iso2709;
use C4::Biblio;
use C4::Items;
use Locale::TextDomain 'Koha-Contrib-Tamil';

has file => ( is => 'rw', isa => 'Str', default => 'dump.mrc' );

has branches => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { {} }
);

has formater => (
    is => 'rw',
    isa => 'Str',
    default => 'marcxml',
);

has koha => (
    is       => 'rw',
    isa      => 'Koha::Contrib::Tamil::Koha',
    required => 0,
);

has verbose => ( is => 'rw', isa => 'Bool', default => 0 );

has sth => ( is => 'rw' );
has sth_marcxml => ( is => 'rw' );
has sth_item => ( is => 'rw' );

has writer => ( is => 'rw', isa => 'MARC::Moose::Writer' );



before 'run' => sub {
    my $self = shift;

    $self->koha( Koha::Contrib::Tamil::Koha->new() ) unless $self->koha;
    #$self->writer(
    #    Koha::Contrib::Tamil::Sitemaper::Writer->new( url => $self->url ) );

    my $where = '';
    if ( my $branches = $self->branches ) {
        $where = ' WHERE homebranch IN (' .
                join(',', map {"'$_'" } @$branches) . ')'
            if @$branches;
    }
    my $sql = "SELECT DISTINCT biblionumber FROM items" . $where;
    my $sth = $self->koha->dbh->prepare($sql);
    $sth->execute();
    $self->sth( $sth );

    $self->sth_marcxml( $self->koha->dbh->prepare(
        "SELECT marcxml FROM biblioitems WHERE biblionumber=?" ) );

    $where = $where
             ? $where . " AND biblionumber=?"
             : " WHERE biblionumber=?";
    $self->sth_item( $self->koha->dbh->prepare(
        "SELECT * FROM items" . $where ) );


    my $fh = new IO::File '> ' . $self->file;
    binmode($fh, ':encoding(utf8)');
    $self->writer( MARC::Moose::Writer->new(
        formater => $self->formater =~ /marcxml/i
                    ? MARC::Moose::Formater::Marcxml->new()
                    : MARC::Moose::Formater::Iso2709->new(),
        fh => $fh ) );
};


before 'start_process' => sub {
    shift->writer->begin();
};


override 'process' => sub {
    my $self = shift;

    my ($biblionumber) = $self->sth->fetchrow;
    return unless $biblionumber;

    $self->sth_marcxml->execute($biblionumber);
    my ($marcxml) = $self->sth_marcxml->fetchrow;
    my $record = MARC::Moose::Record::new_from($marcxml, 'marcxml');

    $self->sth_item->execute($biblionumber);
    while ( my $item = $self->sth_item->fetchrow_hashref ) {
        my $imarc = Item2Marc($item, $biblionumber);
        my $field = $imarc->field('952|995');
        my $f = MARC::Moose::Field::Std->new(
            tag => $field->tag,
            subf => [ $field->subfields ]);
        $record->append($f);
    }
    #say $record->as('Text');

    $self->writer->write($record);
    return super();
};


before 'end_process' => sub {
    shift->writer->end();
};


override 'start_message' => sub {
    my $self = shift;
    say __x("Dump of Koha Catalog into file: {file}",
            file => $self->file);
};


override 'process_message' => sub {
    my $self = shift;
    say $self->count;
};


override 'end_message' => sub {
    my $self = shift;
    say __x("Number of biblio records exported: {biblios}",
              biblios => $self->count );
};


no Moose;
__PACKAGE__->meta->make_immutable;

=pod

=encoding UTF-8

=head1 NAME

Koha::Contrib::Tamil::Biblio::Dumper - Class dumping a Koha Catalog

=head1 VERSION

version 0.030

=HEAD1 SYNOPSIS

 my $task = Koha::Contrib::Tamil->new( 
    url => 'http://opac.mylibrary.org',
    verbose => 1 );
 $task->run();

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut

__END__

1;

