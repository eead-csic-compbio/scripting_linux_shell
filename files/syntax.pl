#!/usr/bin/env perl

# Adapted from https://learnxinyminutes.com/docs/perl

# this is a comment line

#### Strict and warnings

use strict;
use warnings;

# All perl scripts and modules should include these lines. Strict causes
# compilation to fail in cases like misspelled variable names, and
# warnings will print warning messages in case of common pitfalls like
# concatenating to an undefined value.

#### Perl variable types

#  Variables begin with a sigil, which is a symbol showing the type.
#  A valid variable name starts with a letter or underscore,
#  followed by any number of letters, numbers, or underscores.

### Perl has three main variable types: $scalar, @array, and %hash.

## Scalars
#  A scalar represents a single value:
my $animal = "camel";
my $answer = 42;
my $display = "You have $answer ${animal}s.\n";

# Scalar values can be strings, integers or floating point numbers, and
# Perl will automatically convert between them as required.

# Strings in single quotes are literal strings. Strings in double quotes
# will interpolate variables and escape codes like "\n" for newline.

## Arrays
#  An array represents a list of values:
my @animals = ("camel", "llama", "owl");
my @numbers = (23, 42, 69);
my @mixed   = ("camel", 42, 1.23);

# Array elements are accessed using square brackets, with a $ to
# indicate one value will be returned.
my $second = $animals[1];

# The size of an array is retrieved by accessing the array in a scalar
# context, such as assigning it to a scalar variable or using the
# "scalar" operator.

my $num_animals = @animals;
print "Number of numbers: ", scalar(@numbers), "\n";

# Be careful when using double quotes for strings containing symbols
# such as email addresses, as it will be interpreted as a variable.

my @example = ('secret', 'array');
my $oops_email = "foo@example.com"; # 'foosecret array.com'
my $ok_email = 'foo@example.com';

## Hashes
#   A hash represents a set of key/value pairs:

my %fruit_color = ("apple", "red", "banana", "yellow");

#  You can use whitespace and the "=>" operator to lay them out more
#  nicely:

%fruit_color = (
  apple  => "red",
  banana => "yellow",
);

# Hash elements are accessed using curly braces, again with the $ sigil.
my $color = $fruit_color{apple};

# All of the keys or values that exist in a hash can be accessed using
# the "keys" and "values" functions.
my @fruits = keys %fruit_color;
my @colors = values %fruit_color;

# Scalars, arrays and hashes are documented more fully in perldata.
# (perldoc perldata).

#### Conditional and looping constructs

# Perl has most of the usual conditional and looping constructs.
my ($var, $zippy, $bananas) = (0,1,0);

if ($var) {
  #...
} elsif ($var eq 'bar') {
  #...
} else {
  #...
}

# the Perlish post-condition way
print "Yow!\n" if $zippy;
print "We have no bananas\n" unless $bananas;

#  while 
while ($var) {
  #...
}

# for loops and iteration
my $max = 5;
for my $i (0 .. $max) {
  print "index is $i\n";
}

my @elements = (1,2,3);
for my $element (@elements) {
  print $element, "\n";
}

map { print "$_\n" } @elements;

# iterating through a hash (for and foreach are equivalent)
foreach my $key (keys %fruit_color) {
  print $key, ': ', $fruit_color{$key}, "\n";
}

#### Regular expressions

# Perl's regular expression support is both broad and deep, and is the
# subject of lengthy documentation in perlrequick, perlretut, and
# elsewhere. However, in short:

my $x = 'bar';

# Simple matching

#if (/foo/) { 
  # true if $_, usually current line or element, contains "foo"
#}

if ($x =~ /foo/) { 
  # true if $x contains "foo"
}

# Simple substitution

$x =~ s/foo/bar/;         # replaces foo with bar in $x
$x =~ s/foo/bar/g;        # replaces ALL INSTANCES of foo with bar in $x
