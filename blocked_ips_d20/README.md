
u've retrieved the list of blocked IPs from the firewall, but the list seems to 
be messy and poorly maintained, and it's not clear which IPs are allowed. Also, 
rather than being written in dot-decimal notation, they are written as plain 
32-bit integers, which can have any value from 0 through 4294967295, inclusive.

For example, suppose only the values 0 through 9 were valid, and that you 
retrieved the following blacklist:

5-8
0-2
4-7

The blacklist specifies ranges of IPs (inclusive of both the start and end value) that are not allowed. Then, the only IPs that this firewall allows are 3 and 9, since those are the only numbers not in any range.

Given the list of blocked IPs you retrieved from the firewall (your puzzle input), what is the lowest-valued IP that is not blocked?

** take each range, grab the number right below the lowest.  Carry it to the 
next range. 

better ...
sort ranges by lowest starting point to highest.  
Read up on Range functionality, see if Ruby can combine ranges easily.
If not, code own solution for consolidating overlapping ranges, to get a final 
range.


## what I want to fix; ##

I used 'inject' in a non-standard way.  Look at 'enumerator' for something better
Found each_cons. Never used that, let's try it out!

