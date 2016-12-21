## problem ##
count the number of safe tiles in a room, given the first row.

Rules for determining next row

take preceding row, and generate next row
walls are considered untrapped

. == safe
^ == trap

take first three chars
trap in these cases
..^
.^^
^^.
^..

## strategy to find each position. ##

custom rule for first and last elements.

scan the rest, matching /(.(?:(..))/

grabs one char, in var 1, and two more, (in var 2), but non-capturing "(?=)" 

forward lookup means we pick up on the next character, rather than after the entire match.

one method that takes three chars, and returns ^ or .


test data:
```
.^^.^.^^^^
^^^...^..^
^.^^.^.^^.
..^^...^^^
.^^^^.^^.^
^^..^.^^..
^^^^..^^^.
^..^^^^.^^
.^^^..^.^^
^^.^^^..^^
```
