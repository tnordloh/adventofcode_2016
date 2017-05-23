problem:

Build a simple register

four positions; each can hold any integer

instructions are:

    cpy x y copies x (either an integer or the value of a register) into register y.
    inc x increases the value of register x by one.
    dec x decreases the value of register x by one.
    jnz x y jumps to an instruction y away (positive means forward; negative means backward), but only if x is not zero.

## Strategy ##

Build a test with given data

Build a parser for instructions.

Pre-load instructions, to allow jumping forward or back.
* this may require another test, since arithmetic is hard.

Try parsing the instructions

Parsing:
split on white space, then redirect based on instructions.
I'm thinking 'send', to really simplify the code.
