package Koha::Contrib::Tamil::EchoWatcher;
{
  $Koha::Contrib::Tamil::EchoWatcher::VERSION = '0.001';
}
# ABSTRACT: A watch echoing a process messages

use Moose;
use AnyEvent;

has delay   => ( is => 'rw', isa => 'Int', default => 1 );
has action  => ( is => 'rw', does => 'Koha::Contrib::Tamil::WatchableTask' );
has stopped => ( is => 'rw', isa => 'Int', default => 0 );

has wait => ( is => 'rw' );


sub start {
    my $self = shift;

    $self->action->start_message(),
    $self->wait( AnyEvent->timer(
        after => $self->delay,
        interval => $self->delay,
        cb    => sub {
            $self->action()->process_message(),
        },
    ) );
}


sub stop {
    my $self = shift;
    $self->action->end_message();
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;


__END__
=pod

=head1 NAME

Koha::Contrib::Tamil::EchoWatcher - A watch echoing a process messages

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

