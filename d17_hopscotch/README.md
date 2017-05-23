finding steps, in changing maze

## vault shape ##
```
#########
#S| | | #
#-#-#-#-#
# | | | #
#-#-#-#-#
# | | | #
#-#-#-#-#
# | | |  
####### V
```

1 -> 2,5
2 => 1,3,6
3 => 2,4,7
4 => 3,8
5 => 6,9 
6 => 5,7,2,10
7 => 6,9,3,11
8 => 7,4,12
9 => 10,5,13
10 => 9,11,6,14
11 => 8,10,7,15
12 => 11,8,16
13 => 9,14
14 => 10,13,15
15 => 11,14,16
16 => 12,15

Breadth first search; 
find directions
repeats allowed

depth first search
step 1
initial position
choose node at random.
  Is it the longest so far?
  yes ;
     put in 'longest'
  no ; 
     does it have children?
     yes
       have all children been explored?
       yes
         discard
       no
         feed node to 'initial position'
     no
       discard.
