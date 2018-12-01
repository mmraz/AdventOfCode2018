#!/usr/bin/env perl
use List::MoreUtils qw( firstidx );

my $freq = 0;
my @changes;
my @freqs;
push @freqs, $freq;

open(FIN, "<inputs/in");
while(<FIN>) {
    chomp;
    push @changes, $_;
}
close(FIN);

my $idx = -1;
while( $idx == -1 ) {
    foreach(@changes) {
        $freq += $_;
        $idx = firstidx { $_ == $freq } @freqs;
        if( $idx >= 0 ) {
            print "$freq\n";
            last;
        }
        push @freqs, $freq;
    }
}
