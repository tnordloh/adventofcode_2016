# decompress #
## tests ##
use examples to create initial test

## decompress string ##
basic algorithm
read string, up to first decompress
decompress the part discovered so far
remove decompressed string from original
repeat until decompressed is empty

# methods #
use String.match
matchdata object returns entire match, as well as parenthesized 
sections.  This should be enough to give us the data we need.

# part 2 -- count #
figure out character count
## tests ##

basic algorithm
X(8x2)(3x3)ABCY

count chars before parens.
chars inside parens:
  count chars up to parens.  If less than total, count is their
  multiplier + chars 
