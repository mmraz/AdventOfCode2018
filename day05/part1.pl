#!/usr/bin/env perl

my $DEBUG = 0;

open(FIN, "<inputs/in");
my @inputs;
while(<FIN>) {
    chomp;
    @inputs = split(//, $_);
}
close(FIN);
my $ended = 1;
while($ended) {
  for my $i (0 .. $#inputs-1) {
    if(lc($inputs[$i]) eq lc($inputs[$i+1]) && $inputs[$i] ne $inputs[$i+1]) {
        print "$i == $inputs[$i] $inputs[$i+1]\n" if $DEBUG;
        print "#b $#inputs" if $DEBUG;
        splice(@inputs, $i, 2);
        print " #a $#inputs\n" if $DEBUG;
        last;
    }
    $ended = 0 if $i == ($#inputs-1);
  }
}
print join('', @inputs) . "\n" if $DEBUG;
print $#inputs+1 . "\n";
