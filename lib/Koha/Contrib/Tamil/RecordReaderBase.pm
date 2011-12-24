package Koha::Contrib::Tamil::RecordReaderBase;
{
  $Koha::Contrib::Tamil::RecordReaderBase::VERSION = '0.001'; # TRIAL
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

=head1 NAME

Koha::Contrib::Tamil::RecordReaderBase - Records reader base class

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

