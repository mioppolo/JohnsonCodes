#
# JohnsonCodes: Description
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "JohnsonCodes",
Subtitle := "SIT-Codes in Johnson Graphs",
Version := "0.1",
Date := "05/04/2029", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Mark",
    LastName := "Ioppolo",
    WWWHome := "https://github.com/mioppolo/JohnsonCodes",
    Email := "mioppolo.math@gmail.com",
    PostalAddress := "",
    Place := "",
    Institution := "",
  ),
],

#SourceRepository := rec( Type := "TODO", URL := "URL" ),
#IssueTrackerURL := "TODO",
PackageWWWHome := "homepageurl/",
PackageInfoURL := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL     := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL     := Concatenation( ~.PackageWWWHome,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "JohnsonCodes",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Description",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [
          ["Forms", ">=1.2.3"],
          ["GAPDoc", ">= 1.6"],
          ["GenSS", ">=1.6.4"],
          ["GRAPE", ">=4.7"],
          ["Orb", ">=4.7.6"],
          ["fining", ">=1.4.1"],
          ["sonata", ">=2.9.1"]],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));
