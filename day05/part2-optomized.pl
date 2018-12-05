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
my $polymers = join('', @inputs);

my $lowest = length $polymers;

# This runs orders of magnitude faster if iterated over the reacted polymer
for my $letter ('a' .. 'z') {
  $ended = 1;
  my $lu = $letter . uc($letter);
  my $poly =  $polymers;
  $poly =~ s/[$lu]//g;
  print "$poly\n" if $DEBUG;
  print "- $lu $ul\n" if $DEBUG;
  my @input = split(//,$poly);
  print "# $#input\n" if $DEBUG;

  while($ended) {
    for my $i (0 .. $#input-1) {
      if(lc($input[$i]) eq lc($input[$i+1]) && $input[$i] ne $input[$i+1]) {
        print "$i == $input[$i] $input[$i+1]\n" if $DEBUG;
        print "#b $#input" if $DEBUG;
        splice(@input, $i, 2);
        print " #a $#input\n" if $DEBUG;
        last;
      }
      $ended = 0 if $i == ($#input-1);
    }
  }
  if($#input < $lowest) { 
      print "$lowest = $#input\n" if $DEBUG;
      $lowest = $#input;
  }
}
print $lowest+1 . "\n";
