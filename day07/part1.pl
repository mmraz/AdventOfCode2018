#!/usr/bin/env perl
use Data::Dumper qw(Dumper);
use List::MoreUtils qw(all uniq);
 
 
my $DEBUG = 0;

open(FIN, "<inputs/in");
my %inputs;
my @letters;
while(<FIN>) {
    chomp;
    m/Step (\w) must be finished before step (\w) /;
    push(@{$inputs{$2}}, $1);
    push(@letters, ($1,$2));
}
close(FIN);
@letters = uniq(@letters);

foreach my $letter (@letters) {
    if(!exists $inputs{$letter}) {
        $inputs{$letter} = [];
    }
    else {
        my @foo = sort @{$inputs{$letter}};
        print Dumper \@foo if $DEBUG;
        $inputs{$letter} = [];
        push(@{$inputs{$letter}}, @foo);
    }
}
print Dumper \%inputs if $DEBUG;

my %comp_deps;
my @order;

while (keys %comp_deps < keys %inputs) {
    my @next = sort { $a cmp $b } grep { not exists $comp_deps{$_} and all { exists $comp_deps{$_} } @{$inputs{$_}} } @letters;
    push(@order, $next[0]);
    $comp_deps{$next[0]} = 1;
}
print join('',@order) . "\n";
