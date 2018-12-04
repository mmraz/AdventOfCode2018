#!/usr/bin/env perl
use List::Util qw(sum);
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
my $sleepiest_min = 0;
for my $g (keys %guards) {
    my $mins_asleep = sum values $guards{$g};
    if( $mins_asleep > $sleep ) {
        print "$sleep <= $mins_asleep, $guard < $g\n" if $DEBUG;
        $guard = $g;
        $sleep = $mins_asleep;
        print Dumper $guards{$g} if $DEBUG;
        $sleepiest_min = max_by { $guards{$g}{$_} } keys $guards{$g};
        print "$sleepiest_min SM\n" if $DEBUG;
    }
}
print "$guard * $sleepiest_min \n" if $DEBUG;
print $guard * $sleepiest_min;
print "\n";
