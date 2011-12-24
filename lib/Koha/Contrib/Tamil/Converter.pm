package Koha::Contrib::Tamil::Converter;
{
  $Koha::Contrib::Tamil::Converter::VERSION = '0.001'; # TRIAL
}
# ABSTRACT: Role for any converter class

use Moose::Role;

requires 'convert';

1;


__END__
=pod

=head1 NAME

Koha::Contrib::Tamil::Converter - Role for any converter class

=head1 VERSION

version 0.001

=head1 AUTHOR

Frederic Demians <f.demians@tamil.fr>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Frederic Demians.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

