
Get the index of the 64th key for a one-time pad.

## criteria ##

hash must have 3 of the same character in a row AND
those same characters must appear 5 times in a row on some subsequent key.

abc0 ... abcn
abc18 contains 888
this is not valid, because it doesn't show up again before key 1018

abc39 is the first key, with 'eeee', matching index 816

92  matches with 200

22728 is the 64th key

