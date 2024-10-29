#!/bin/sh

as -o random-guess-game.o random-guess-game.s
ld -o random-guess-game random-guess-game.o
rm random-guess-game.o
