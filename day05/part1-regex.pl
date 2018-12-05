#!/usr/bin/env perl
my $DEBUG = 0;

open(FIN, "<inputs/in");
my $inputs;
while(<FIN>) {
    chomp($inputs =  $_);
}
close(FIN);

my $pattern = join '|' => map {"$_\u$_|\u$_$_"} 'a'..'z';
print "$pattern\n" if $DEBUG;
1 while $inputs =~ s/$pattern//g;
print length($inputs) . "\n";
