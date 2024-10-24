#!/bin/sh

as -o hello-world.o hello-world.s
ld -o hello-world hello-world.o
rm hello-world.o
