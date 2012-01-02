package Koha::Contrib::Tamil::Converter;
{
  $Koha::Contrib::Tamil::Converter::VERSION = '0.006';
}
# ABSTRACT: Role for any converter class

use Moose::Role;

requires 'convert';

1;


__END__
=pod

=encoding UTF-8

=head1 NAME

Koha::Contrib::Tamil::Converter - Role for any converter class

=head1 VERSION

version 0.006

=head1 AUTHOR

Frédéric Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Fréderic Démians.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

