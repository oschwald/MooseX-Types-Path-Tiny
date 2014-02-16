# NAME

MooseX::Types::Path::Tiny - Path::Tiny types and coercions for Moose

# VERSION

version 0.010

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

    has filenames => (
      is => 'ro',
      isa => Paths,
      coerce => 1,
    );

    ### usage in code

    Foo->new( filename => 'foo.txt' ); # coerced to Path::Tiny
    Foo->new( directory => '.' ); # coerced to path('.')->absolute

# DESCRIPTION

This module provides [Path::Tiny](https://metacpan.org/pod/Path::Tiny) types for [Moose](https://metacpan.org/pod/Moose).  It handles
two important types of coercion:

- coercing objects with overloaded stringification
- coercing to absolute paths

It also can check to ensure that files or directories exist.

# SUBTYPES

This module uses [MooseX::Types](https://metacpan.org/pod/MooseX::Types) to define the following subtypes.

## Path

`Path` ensures an attribute is a [Path::Tiny](https://metacpan.org/pod/Path::Tiny) object.  Strings and
objects with overloaded stringification may be coerced.

## AbsPath

`AbsPath` is a subtype of `Path` (above), but coerces to an absolute path.

## File, AbsFile

These are just like `Path` and `AbsPath`, except they check `-f` to ensure
the file actually exists on the filesystem.

## Dir, AbsDir

These are just like `Path` and `AbsPath`, except they check `-d` to ensure
the directory actually exists on the filesystem.

## Paths, AbsPaths

These are arrayrefs of `Path` and `AbsPath`, and include coercions from
arrayrefs of strings.

# CAVEATS

## Path vs File vs Dir

`Path` just ensures you have a [Path::Tiny](https://metacpan.org/pod/Path::Tiny) object.

`File` and `Dir` check the filesystem.  Don't use them unless that's really
what you want.

## Usage with File::Temp

Be careful if you pass in a [File::Temp](https://metacpan.org/pod/File::Temp) object. Because the argument is
stringified during coercion into a [Path::Tiny](https://metacpan.org/pod/Path::Tiny) object, no reference to the
original [File::Temp](https://metacpan.org/pod/File::Temp) argument is held.  Be sure to hold an external reference to
it to avoid immediate cleanup of the temporary file or directory at the end of
the enclosing scope.

A better approach is to use [Path::Tiny](https://metacpan.org/pod/Path::Tiny)'s own `tempfile` or `tempdir`
constructors, which hold the reference for you.

    Foo->new( filename => Path::Tiny->tempfile );

# SEE ALSO

- [Path::Tiny](https://metacpan.org/pod/Path::Tiny)
- [Moose::Manual::Types](https://metacpan.org/pod/Moose::Manual::Types)
- [Types::Path::Tiny](https://metacpan.org/pod/Types::Path::Tiny)

# AUTHOR

David Golden <dagolden@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by David Golden.

This is free software, licensed under:

    The Apache License, Version 2.0, January 2004

# CONTRIBUTORS

- Karen Etheridge <ether@cpan.org>
- Toby Inkster <mail@tobyinkster.co.uk>
