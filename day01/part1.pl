#!/usr/bin/env perl
use List::Util qw( sum );

open(FIN, "<inputs/in");
my @changes;
while(<FIN>) {
    chomp;
    push @changes,  $_;
}
close(FIN);
print sum(@changes) . "\n";
