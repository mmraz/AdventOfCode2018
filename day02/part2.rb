#!/usr/bin/env ruby
require 'pp'
DEBUG = false
inWords = File.readlines('inputs/in').map(&:chomp)

for word in inWords
    for iword in inWords
        diffs = word.chars.select.each_with_index.to_a - iword.chars.select.each_with_index.to_a
        if( diffs.length == 1 )
            code = word.chars
            code.delete_at(diffs[0][1])
            puts code.join
            puts "#{word}\n#{iword}\n" if DEBUG
            pp diffs if DEBUG
            exit
        end
    end
end
