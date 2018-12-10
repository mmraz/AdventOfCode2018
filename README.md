# AdventOfCode2018
My personal solutions to the 2018 Advent of Code puzzles

To get my inputs, upload answers and check my private leaderboard I'm using
[aoc-tools](https://github.com/foo-jin/aoc-tools)

All code prints the answer to STDOUT

```
cd day##
aoc fetch -d ## > inputs/in
./part1.pl | aoc submit -d ## -l 1
./part2.rb | aoc submit -d ## -l 2
aoc leaderboard
```
Perl is the language used for most solutions and may use some CPAN library modules.  The module list to install in order to be able to run all solutions is:

```
List::Util
List::MoreUtils
List::UtilsBy
Data::Dumper (optional, required for $DEBUG being enabled)
Array::Compare
Array::Circular
```

Committing changes without tracking pulled inputs is done by a one time
git-index setting to force not staging changes.

```
for i in $(seq -w 1 25)
do
git update-index --assume-unchanged day${i}/inputs/in
done
```
