#!/usr/bin/env perl
use List::MoreUtils qw(zip6);
use List::Util qw(max sum);
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent = 1;

my $DEBUG = 0;

open(FIN, "<inputs/in");
my @x, @y, @grid, @inputs;
while(<FIN>) {
    chomp;
    (my $xin, my $yin) =  split(/, /, $_);
    push(@x, $xin);
    push(@y, $yin);
}
close(FIN);

@inputs = zip6(@x, @y);
my $max_x = max(@x);
my $max_y = max(@y);

print Dumper \@inputs if $DEBUG;

my $grid = [];
my $safe = 0;

foreach my $x (0 .. $max_x) {
    foreach my $y (0 .. $max_y) {
        my @distances =
            sort {$$a[1] <=> $$b[1]}
            map  {[$_, abs ($inputs[$_][0] - $x) + abs ($inputs[$_][1] - $y)]} keys @inputs;
        if ($distances[0][1] == $distances[1][1]) {
            $$grid[$x][$y] = "x";
        }
        else {
            $$grid[$x][$y] = $distances[0][0];
        }
        my $distsum = sum( map {$$_[1]} @distances);
        $safe ++ if $distsum < 10000;
    }
}

my %ignore;
foreach my $x (0, $max_x) {
    foreach my $y (0 .. $max_y) {
        $ignore {$$grid[$x][$y]} = 1;
    }
}
foreach my $x (0 .. $max_x) {
    foreach my $y (0, $max_y) {
        $ignore {$$grid[$x][$y]} = 1;
    }
}

foreach my $x (0 .. $max_x) {
    foreach my $y (0 .. $max_y) {
        $$grid[$x][$y] = "x" if $ignore {$$grid[$x][$y]};
    }
}

my %counts;
foreach my $row (@$grid) {
    foreach my $cell (@$row) {
        $counts {$cell} ++;
    }
}
delete $counts {"x"};

print Dumper \%count if $DEBUG;
print "$safe\n";
