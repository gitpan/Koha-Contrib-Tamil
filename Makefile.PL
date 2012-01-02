
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Various scripts to manage Koha instances",
  "AUTHOR" => "Fr\303\251d\303\251ric Demians <f.demians\@tamil.fr>",
  "BUILD_REQUIRES" => {
    "FindBin" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "Koha-Contrib-Tamil",
  "EXE_FILES" => [
    "bin/koha-index-daemon",
    "bin/koha-index",
    "bin/koha-cloud",
    "bin/koha-auth"
  ],
  "LICENSE" => "gpl",
  "NAME" => "Koha::Contrib::Tamil",
  "PREREQ_PM" => {
    "AnyEvent" => 0,
    "Carp" => 0,
    "DBI" => 0,
    "Fatal" => 0,
    "File::Path" => 0,
    "File::Temp" => 0,
    "Getopt::Long" => 0,
    "IO::File" => 0,
    "List::Util" => 0,
    "Locale::TextDomain" => 0,
    "Log::Dispatch" => 0,
    "Log::Dispatch::File" => 0,
    "Log::Dispatch::Screen" => 0,
    "MARC::Batch" => 0,
    "MARC::File::XML" => 0,
    "MARC::Record" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::Getopt" => 0,
    "Pod::Usage" => 0,
    "XML::Simple" => 0,
    "YAML" => 0,
    "YAML::Syck" => 0,
    "ZOOM" => 0,
    "diagnostics" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.005",
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



