#!/usr/bin/env perl
use warnings;
use Data::Dumper qw(Dumper);
$Data::Dumper::Indent = 1;
use List::Util qw(max min);

my $DEBUG = 0;

my @points;
open(FIN, "<inputs/in");
while(<FIN>) {
    chomp;
    chomp;
    m/position=<\s?(-?\d+),\s+(-?\d+)> velocity=<\s?(-?\d+),\s+(-?\d+)>/;
    push @points, [$1, $2, $3, $4];
}
close(FIN);

my $seconds = 0;

sub ascii_art {
  my %positions = ();
  my @xs = ();
  my @ys = ();
  for (@points) {
    $positions{$_->[0] . " " . $_->[1]} = 1;
    push @xs, $_->[0];
    push @ys, $_->[1];
  }
   my $x_min = min @xs;
   my $x_max = max @xs;
   my $y_min = min @ys;
   my $y_max = max @ys;
  for my $y ($y_min..$y_max) {
    for my $x ($x_min..$x_max) {
      print $positions{$x . " " . $y} ? 'X' : ' ';
    }
    print "\n";

  }
  print "$seconds\n";
}

sub move {
  for (@points) {
    $_->[0] += $_->[2];
    $_->[1] += $_->[3];
  }
}

sub shrinkage {
    my @ys = ();
    for (@points) {
        push(@ys, $_->[1]);
    }
    return( max(@ys) - min(@ys) );
}

sub backup {
  for (@points) {
    $_->[0] -= $_->[2];
    $_->[1] -= $_->[3];
  }
}

my $y_width = shrinkage();
while (1) {
  move();
  my $new_y_width = shrinkage();
  if($new_y_width > $y_width) { 
      backup;
      ascii_art();
      last;
  }
  $seconds++;
  $y_width = $new_y_width;
}
