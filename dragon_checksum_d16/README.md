# dragon checksum #


## part 1 ##

1.   Call the data you have at this point "a".
2.    Make a copy of "a"; call this copy "b".
3.    Reverse the order of the characters in "b".
4.    In "b", replace all instances of 0 with 1 and all 1s with 0.
5.    The resulting data is "a", then a single 0, then "b".

## test data ##

*    1 becomes 100.
*    0 becomes 001.
*    11111 becomes 11111000000.
*    111100001010 becomes 1111000010100101011110000.

## part 2 ##
for each pair, if they match, checksum is 0, if they don't match, checksum is 1
if resulting checksum length is even, repeat, otherwise done.
*    Consider each pair: 11, 00, 10, 11, 01, 00.
*    These are same, same, different, same, different, same, producing 110101.
*    The resulting string has length 6, which is even, so we repeat the process.
*    The pairs are 11 (same), 01 (different), 01 (different).
*    This produces the checksum 100, which has an odd length, so we stop.

test data
110010110100 is 100

