#!/usr/bin/env perl

open(FIN, "<inputs/in");
my @words;
while(<FIN>) {
    chomp;
    push @words,  $_;
}
close(FIN);

my %counts = { 2 => 0, 3 => 0 };
foreach (@words) {
    my %symbol;
    for ( split // ) {
        $symbol{ $_ }++;
    }
    if( 2 ~~ [values %symbol] ) { $counts{2}++; }
    if( 3 ~~ [values %symbol] ) { $counts{3}++; }
}

print $counts{2} * $counts{3} . "\n";
