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

my @metadata;

sub tree_build {
    my $children = shift @inputs;
    my $metas = shift @inputs;

    for(1..$children) {
        tree_build();
    }
    my @meta = splice @inputs, 0, $metas;
    push(@metadata,@meta);
}

tree_build();
print sum(@metadata) . "\n";
