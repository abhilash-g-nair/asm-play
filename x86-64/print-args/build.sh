#!/bin/sh

set -e

as -o print-args.o print-args.s
ld -o print-args print-args.o
rm print-args.o
