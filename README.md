# NAME

MooseX::Types::Path::Tiny - Path::Tiny types and coercions for Moose

# VERSION

version 0.006

# SYNOPSIS

    ### specification of type constraint with coercion

    package Foo;

    use Moose;
    use MooseX::Types::Path::Tiny qw/Path AbsPath/;

    has filename => (
      is => 'ro',
      isa => Path,
      coerce => 1,
    );

    has directory => (
      is => 'ro',
      isa => AbsPath,
      coerce => 1,
    );

    ### usage in code

    Foo->new( filename => 'foo.txt' ); # coerced to Path::Tiny
    Foo->new( directory => '.' ); # coerced to path('.')->absolute

# DESCRIPTION

This module provides [Path::Tiny](http://search.cpan.org/perldoc?Path::Tiny) types for Moose.  It handles
two important types of coercion:

- coercing objects with overloaded stringification
- coercing to absolute paths

It also can check to ensure that files or directories exist.

# SUBTYPES

This module uses [MooseX::Types](http://search.cpan.org/perldoc?MooseX::Types) to define the following subtypes.

## Path

`Path` ensures an attribute is a [Path::Tiny](http://search.cpan.org/perldoc?Path::Tiny) object.  Strings and
objects with overloaded stringification may be coerced.

## AbsPath

`AbsPath` is a subtype of `Path` (above), but coerces to an absolute path.

## File, AbsFile

These are just like `Path` and `AbsPath`, except they check `-f` to ensure
the file actually exists on the filesystem.

## Dir, AbsDir

These are just like `Path` and `AbsPath`, except they check `-d` to ensure
the directory actually exists on the filesystem.

# CAVEATS

## Path vs File vs Dir

`Path` just ensures you have a [Path::Tiny](http://search.cpan.org/perldoc?Path::Tiny) object.

`File` and `Dir` check the filesystem.  Don't use them unless that's really
what you want.

## Usage with File::Temp

Be careful if you pass in a File::Temp object. Because the argument is
stringified during coercion into a Path::Tiny object, no reference to the
original File::Temp argument is held.  Be sure to hold an external reference to
it to avoid immediate cleanup of the temporary file or directory at the end of
the enclosing scope.

A better approach is to use Path::Tiny's own `tempfile` or `tempdir`
constructors, which hold the reference for you.

    Foo->new( filename => Path::Tiny->tempfile );

# SEE ALSO

- [Path::Tiny](http://search.cpan.org/perldoc?Path::Tiny)
- [Moose::Manual::Types](http://search.cpan.org/perldoc?Moose::Manual::Types)
- [Types::Path::Tiny](http://search.cpan.org/perldoc?Types::Path::Tiny)

# AUTHOR

David Golden <dagolden@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by David Golden.

This is free software, licensed under:

    The Apache License, Version 2.0, January 2004