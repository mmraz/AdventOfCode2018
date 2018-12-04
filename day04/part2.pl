#!/usr/bin/env perl
use List::Util qw(max);
use List::UtilsBy qw(max_by);
use Data::Dumper qw(Dumper);

my $DEBUG = 0;

open(FIN, "<inputs/in");
my @inputs;
while(<FIN>) {
    chomp;
    push @inputs,  $_;
}
close(FIN);

my %guards;
my $guard, $sleep, $wake = 0;

for my $shift (@inputs) {
    if($shift =~ m/Guard #(\d+)/) {
        $guard = $1;
        $sleep = 0;
        $wake = 0;
        next;
    }
    if($shift =~ m/:(\d+)\] falls/) {
        $sleep = $1;
        next;
    }
    if($shift =~ m/:(\d+)\] wakes/) {
        $wake = $1;
        foreach($sleep..$wake-1) {
            $guards{$guard}{$_}++;
        }
        next;
    }
    
}


$sleep = $guard = 0;
for my $g (keys %guards) {
    my $max_min = max values $guards{$g};
    print "$max_min max_min\n" if $DEBUG;
    if( $max_min > $sleep ) {
        print "$sleep <= $max_min, $guard < $g\n" if $DEBUG;
        $guard = $g;
        $sleep = $max_min;
        print Dumper $guards{$g} if $DEBUG;
    }
}
$sleep = max_by { $guards{$guard}{$_} } keys $guards{$guard};
print "$guard * $sleep \n" if $DEBUG;
print $guard * $sleep;
print "\n";
