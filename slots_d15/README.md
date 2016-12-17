problem.  Find a point when 5 rotating numbers, changing 
at the same rate, line up with each other.

example:
```
4 0 1 2 3
1 0 1 0 1 0

0 1 2 3 4
0 1 0 1 0

1 2 3 4 0
1 0 1 0 1

2 3 4 0 1
0 1 0 1 0

3 4 0 1 2
1 0 1 0 1

c  <====drop coin
4 0 1 2 3
0 1 0 1 0
    ^ upcoming 0 on line 2
```

matching points would be


solution:
rotate until disk 1 has 0 in the second slot (address 1)
and slot 2 has 0 in second slot
....
and slot n has 0 in the n+1 slot

normalize the arrays by multiplying them to be at least as long as the shortest array.


