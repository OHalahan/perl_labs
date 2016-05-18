#!/usr/bin/perl

use strict;
use warnings;

# A small library's database is stored in a file books.txt .
#
# Write a console application which manages the database.
# It prints on a terminal all possible actions and waits for a user input.
#
# load <file>        - loads the database file;
# search [<pattern>] - searches for books by a given pattern. If a patten is not specified,
# the program prints all possible search srategies and waits until a user types a number of the strategy:
# - by name
# - by author
# - ..
#
# After choosing the strategy, the program prompts "Type a criteria" then waits for a user input.
#
# add book - push a user through a dialog which prints prompts "Type book name", "Type author", etc.
# After that saves a new book to the database;
#
# delete book <pattern> - deletes books; command find books by pattern, prints all found books.
# Then prints each found book and asks delete conformation. user types action yY - delete book
# nN - skip book A - detete all books remained in a list.
#
# PATTERN examples: name=Java* author='Randal Schwartz' reader='Jimmy Fox' shelf=1 tag=XML|Python
#
# NOTES:
# Use closures for implementing iterators of found books. Use "event driven" paradigm while implementing this application.
# You may implement other action, which your program could support.

sub greeting {
    print "Enter the required action and press ENTER:\n";
}

sub load_database {
    print "Enter the path to the file: ";
    chomp ( my $file = <STDIN> );
    open ( my $database, "<", $file ) or print "Cannot open a file $file: $!\n";
    my ( $title, $author, $section, $shelf, $taken );
    while ( <$database> ) {
        chomp;
        if ( /^Title/ ) {
            $title = s/^Title:\s//r;
        } elsif ( /^Author/ ) {
            $author = s/^Author:\s//r;
        } elsif ( /^Section/ ) {
            $section = s/^Section:\s//r;
        } elsif ( /^Shelf/ ) {
            $shelf = s/^Shelf:\s//r;
        } elsif ( /^On Hands/ ) {
            $taken = s/^On Hands:\s//r;
        } elsif ( /^$/ && $title && $author ) {
            print "Done row $.\n";
        }
    }
    close $database;
}

for ( greeting; <STDIN>; greeting ) {
    chomp;
    load_database;
}
