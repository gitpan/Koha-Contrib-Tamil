
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share dist => "share";


my %WriteMakefileArgs = (
  "ABSTRACT" => "Various scripts to manage Koha instances",
  "AUTHOR" => "Fr\303\251d\303\251ric Demians <f.demians\@tamil.fr>",
  "BUILD_REQUIRES" => {
    "File::Find" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.03"
  },
  "DISTNAME" => "Koha-Contrib-Tamil",
  "EXE_FILES" => [
    "bin/koha-claim",
    "bin/koha-cloud",
    "bin/koha-auth",
    "bin/koha-index",
    "bin/koha-sitemap",
    "bin/koha-dump-biblio",
    "bin/koha-index-daemon",
    "bin/koha-rebuild-editors"
  ],
  "LICENSE" => "gpl",
  "NAME" => "Koha::Contrib::Tamil",
  "PREREQ_PM" => {
    "AnyEvent" => 0,
    "AnyEvent::Processor" => 0,
    "AnyEvent::Processor::Conversion" => 0,
    "Business::ISBN" => 0,
    "Carp" => 0,
    "DBI" => 0,
    "DateTime" => 0,
    "Fatal" => 0,
    "File::Path" => 0,
    "File::Temp" => 0,
    "Getopt::Long" => 0,
    "IO::File" => 0,
    "Koha::Contrib::Tamil::RecordWriter::File" => 0,
    "List::Util" => 0,
    "Locale::TextDomain" => 0,
    "MARC::Batch" => 0,
    "MARC::File::XML" => 0,
    "MARC::Moose::Formater::Iso2709" => 0,
    "MARC::Moose::Record" => 0,
    "MARC::Moose::Writer" => 0,
    "MARC::Record" => 0,
    "Modern::Perl" => 0,
    "Moose" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::Getopt" => 0,
    "MooseX::LogDispatch" => 0,
    "MooseX::RW::Reader" => 0,
    "MooseX::RW::Writer::File" => 0,
    "Pod::Usage" => 0,
    "XML::Simple" => 0,
    "XML::Writer" => 0,
    "YAML" => 0,
    "YAML::Syck" => 0,
    "ZOOM" => 0,
    "diagnostics" => 0,
    "feature" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.030",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

{
package
MY;
use File::ShareDir::Install qw(postamble);
}


