# screen test #
based on instructions, modify a screen with pixels on a screen

# initializer #
input of x,y size, 
create empty screen (2d array, filled with ".")



# input  #
file-based
ARGF.readlines.

# output #
number of pixels that are on 

# algorithms #
* rect AxB turns on all of the pixels in a rectangle at the top-left of the screen which is A wide and B tall.

  Create a rectangle in this shape, and overlay it onto the screen.

  This can be done with an map_index  .. or .. some sort of merge?
  * how about zip, then map, with preference for # signs.
 * rotate row y=A by B shifts all of the pixels in row A (0 is the top row) right by B pixels. Pixels that would fall off the right end appear at the left end of the row.
 find the row, call rotate
* rotate column x=A by B shifts all of the pixels in column A (0 is the left column) down by B pixels. Pixels that would fall off the bottom appear at the top of the column.
 transpose, rotate row, transpose back
