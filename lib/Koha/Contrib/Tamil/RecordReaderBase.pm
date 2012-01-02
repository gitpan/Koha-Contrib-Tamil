package Koha::Contrib::Tamil::RecordReaderBase;
{
  $Koha::Contrib::Tamil::RecordReaderBase::VERSION = '0.006';
}
# ABSTRACT: Records reader base class
use Moose;


has count => (
    is => 'rw',
    isa => 'Int',
    default => 0,
);


sub read {
    my $self = shift;
    $self->count($self->count + 1);
    return 1;
}

__PACKAGE__->meta->make_immutable;

1;


__END__
=pod

=encoding UTF-8

=head1 NAME

Koha::Contrib::Tamil::RecordReaderBase - Records reader base class

=head1 VERSION

version 0.006

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

