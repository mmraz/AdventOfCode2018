#!/usr/bin/env perl
use Array::Compare;
use Data::Dumper qw(Dumper);

open(FIN, "<inputs/in");
my %words;
while(<FIN>) {
    chomp;
    $words{$_} = [split(//)];
}
close(FIN);

print Dumper \%words;
my $comp = Array::Compare->new();
foreach my $word (sort(keys %words)) {
    foreach my $inword (sort(keys %words)) {
        my @diffsIdx = $comp->full_compare($words{$word},$words{$inword});
        if( scalar(@diffsIdx) == 1 ) {
            print Dumper $words{$word};
            print Dumper $words{$inword};
            print Dumper \@diffsIdx;
            print scalar($diffsIdx[0]) . "\n";
            splice $words{$word}, $diffsIdx[0], 1;
            my $shorter = eval(Dumper($words{$word}));
            print Dumper $shorter;
            print join('', @$shorter) . "\n";
            exit;
        }
    }
}

