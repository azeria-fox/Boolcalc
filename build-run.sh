#!/usr/bin/env sh

# Blow away any old files
rm -f boolcalc.tab* lex* boolcalc

# Generate files
bison -d boolcalc.y
flex boolcalc.l

# Compile the program
gcc -lm boolcalc.tab.c lex.yy.c -o boolcalc

# Execute the program
./boolcalc
