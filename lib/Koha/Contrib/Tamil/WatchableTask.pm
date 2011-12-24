package Koha::Contrib::Tamil::WatchableTask;
{
  $Koha::Contrib::Tamil::WatchableTask::VERSION = '0.001'; # TRIAL
}
#ABSTRACT: Role for tasks which are watchable

use Moose::Role;

requires 'run';
requires 'process';
requires 'process_message';
requires 'start_message';
requires 'end_message';

1;


__END__
=pod

=head1 NAME

Koha::Contrib::Tamil::WatchableTask - Role for tasks which are watchable

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

