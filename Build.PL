
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "FindBin" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => 0
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Various scripts to manage Koha instances",
  "dist_author" => [
    "Fr\303\251d\303\251ric Demians <f.demians\@tamil.fr>"
  ],
  "dist_name" => "Koha-Contrib-Tamil",
  "dist_version" => "0.003",
  "license" => "gpl",
  "module_name" => "Koha::Contrib::Tamil",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
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
    "perl" => "5.010",
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "bin/koha-index-daemon",
    "bin/koha-index",
    "bin/koha-cloud",
    "bin/koha-auth"
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
