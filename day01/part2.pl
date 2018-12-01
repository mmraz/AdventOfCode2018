#!/usr/bin/env perl
use List::MoreUtils qw( firstidx );

open(FIN, "<inputs/in");
my $freq = 0;
my @changes;
my @freqs;
push @freqs, $freq;
while(<FIN>) {
    chomp;
    push @changes, $_;
}

my $idx = -1;
while( $idx == -1 ) {
    foreach(@changes) {
        $freq += $_;
        print "c: $freq\n";
        $idx = firstidx { $_ == $freq } @freqs;
        print "i: $idx\n";
        if( $idx >= 0 ) {
            print "$freq\n";
            last;
        }
        push @freqs, $freq;
    }
}
