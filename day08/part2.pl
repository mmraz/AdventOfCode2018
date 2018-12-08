#!/usr/bin/env perl
use List::Util qw(sum);
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent = 1;
my $DEBUG = 0;

open(FIN, "<inputs/in");
my @inputs;
while(<FIN>) {
    chomp;
    @inputs = split(/ /, $_);
}
close(FIN);

print Dumper \@inputs if $DEBUG;

sub tree_build {
    my $children = shift @inputs;
    my $metas = shift @inputs;
    my @cmeta_tots;
    my $ctot = 0;

    for(1..$children) {
        push @cmeta_tots, tree_build();
    }
    if($children != 0 ) {
        for(1..$metas) {
          my $md = shift @inputs;
          $ctot += $cmeta_tots[$md - 1] unless $md > scalar(@cmeta_tots);
        }
    }
    else {
        $ctot += sum(splice @inputs, 0, $metas);
    }
    print Dumper \@cmeta_tots if $DEBUG;
    return $ctot;
}

print tree_build() . "\n";
