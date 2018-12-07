#!/usr/bin/env perl
use Data::Dumper qw(Dumper);
use List::MoreUtils qw(all uniq none);
 
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
my %lettertimes;
my $timer = 61;

foreach my $a ('A'..'Z') {
    $lettertimes{$a} = $timer;
    $timer++;
}

my $time = 0;

my @workers = ('.') x 5;
my @tasktimes = (0) x 5;

do {
    for my $worker (0..$#workers) {
        $tasktimes[$worker] --;
        if ($tasktimes[$worker] <= 0) {
            $comp_deps{$workers[$worker]} = 1 if $workers[$worker] ne '.';
            $workers[$worker] = '.';
            my @next = sort { $a cmp $b } grep { not exists $comp_deps{$_} and all { exists $comp_deps{$_} } @{$inputs{$_}} } @letters;
            @next = grep { my $task = $_; none { $_ eq $task } @workers } @next;
            if (@next) {
                $workers[$worker] = $next[0];
                $tasktimes[$worker] = $lettertimes{$next[0]};
            }
        }
    }
    $time++;
} until (all { $_ eq '.' } @workers);

print $time - 1;
print "\n";
