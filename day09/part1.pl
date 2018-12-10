#!/usr/bin/env perl
use Array::Circular;
use List::Util qw(max);
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent = 0;

my $DEBUG = 0;

open(FIN, "<inputs/in");
my $points, $players;
while(<FIN>) {
    chomp;
    m/(\d+) players; last marble is worth (\d+) points/;
    $players = $1;
    $points = $2;
}
close(FIN);

my @circle = (0);
my @elves = (0) x $players;
my $scores = Array::Circular->new(@elves);

print "elf count ", scalar(@elves), " score ", $elves[$scores->index], "\n" if $DEBUG;

my $marble = 0;
my $i = 0;
while( $marble < $points ) {
    $marble++;
    my $marbles = Array::Circular->new(@circle);
    $marbles->index($i);
    # case where scores are increased
    if( $marble % 23 == 0 ) {
        $elves[$scores->index] += $marble;
        $elves[$scores->index] += $marbles->prev(7);
        $i = $marbles->index;
        splice(@circle,$i, 1);
    }
    # case where marbles are added to the circle
    else {
        $marbles->next(2);
        $i = $marbles->index;
        splice(@circle,$i,0,$marble);
    }
    print Dumper \@circle if $DEBUG;
    print "current ", $i, "\n" if $DEBUG;
    # next elf and their score
    $scores->next;
}
 print max(@elves), "\n";
