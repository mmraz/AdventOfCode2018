#!/usr/bin/env perl

open(FIN, "<inputs/in");
my @inputs;
while(<FIN>) {
    chomp;
    push @inputs,  $_;
}
close(FIN);

my %cloth;
for my $claim (@inputs) {
    $claim =~ m/@ (\d+),(\d+): (\d+)x(\d+)/;
    for my $h ($1..$1+$3-1) {
        for my $v ($2..$2+$4-1) {
            $cloth{"$h,$v"}++;
        }
    }
}

claim: for my $claim (@inputs) {
    $claim =~ m/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/;
    for my $h ($2..$2+$4-1) {
        for my $v ($3..$3+$5-1) {
            next claim if $cloth{"$h,$v"} > 1;
        }
    }
    print "$1\n";
}

