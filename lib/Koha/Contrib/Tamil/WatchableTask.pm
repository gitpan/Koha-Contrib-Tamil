package Koha::Contrib::Tamil::WatchableTask;
{
  $Koha::Contrib::Tamil::WatchableTask::VERSION = '0.002';
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

version 0.002

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

