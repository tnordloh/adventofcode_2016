Before you begin, you need to understand the arrangement of data on these nodes. Even though you can only move data between directly connected nodes, you're going to need to rearrange a lot of the data to get access to the data you need. Therefore, you need to work out how you might be able to shift data around.

To do this, you'd like to count the number of viable pairs of nodes. A viable pair is any two nodes (A,B), regardless of whether they are directly connected, such that:

    Node A is not empty (its Used is not zero).
    Nodes A and B are not the same node.
    The data on node A (its Used) would fit on node B (its Avail).


Strategy:
read data into struct that has
'name'
'used'
'avail'

for each node, find all it's pairs and return those pairs.
this is a 'count'
special considerations:
skip current node in summation


## second part ##
need to find a path.
1.  Quickest route is probably along the x axis.
2.  Quickest way to clear is probably to make a bunch of empty spaces

Try moving everything down on the x axis?

