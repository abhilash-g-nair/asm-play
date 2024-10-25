#!/bin/sh

set -e

as -o toy-puts.o toy-puts.s
ld -o toy-puts toy-puts.o
rm toy-puts.o
