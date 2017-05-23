# robot chip sorters #

## I don't know what to do!  So, gather information ##

initial state
bot 1 [3]
bot 2 [2,5]

bot 2 has 2 chips, so distribution is triggered.

bot 2 gives 2 to 1
bot 2 gives 5 to 0

bot 2 has 2 chips, so distribution is triggered.

bot 1 gives 2 to output 1
bot 1 gives 3 to bot 0

bot 0 has 2 chips, so distribution is triggered.


bot 1 gives 3 to output 2
bot 1 gives 5 to output 0

2 in output 1
3 in output 2
5 in output 0

bot 2 is responsible for comparing 5's to 2's

Read input to figure out what bot is responsible for which numbers.

Make an object that records actions for each bot, and figures out what the bot is holding.

29 has 61, passes to 16
