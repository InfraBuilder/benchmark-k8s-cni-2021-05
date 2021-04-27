#!/bin/bash

[ "$1" = "" ] && echo "Missing CNI" && exit 1

export KERNEL="hwe"
export DISTRIBUTION="20.04"
export CNI="$1"

mkdir -p results/$CNI.u$DISTRIBUTION-$KERNEL
asciinema rec results/$CNI.u$DISTRIBUTION-$KERNEL/$CNI.u$DISTRIBUTION-$KERNEL.cast -i 3 -c "./benchmark.sh"