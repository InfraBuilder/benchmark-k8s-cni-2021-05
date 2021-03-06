#!/bin/bash

[ "$CNI" = "" ] && echo "Missing CNI var" && exit 1
[ "$DISTRIBUTION" = "" ] && echo "Missing DISTRIBUTION var" && exit 1
[ "$KERNEL" = "" ] && echo "Missing KERNEL var" && exit 1

export KUBECONFIG="$(pwd)/kubeconfig"

echo "CNI $CNI - Distribution $DISTRIBUTION with kernel $KERNEL"
RESULT_PREFIX="results/$CNI.u$DISTRIBUTION-$KERNEL"

# Deploy nodes with CNI
./setup.sh -c $CNI -m a11 -w a12,a13 -d $DISTRIBUTION -k $KERNEL

for run in 1 2 3
do
    echo "CNI $CNI - Distribution $DISTRIBUTION with kernel $KERNEL - Run $run/3"
    RESULT_FILE_PREFIX="$RESULT_PREFIX-run$run"
    ./knb -v -cn a12 -sn a13 -sbs 256K -t 60 -o data -f $RESULT_FILE_PREFIX.knbdata --name "Ubuntu $DISTRIBUTION - Kernel $KERNEL - $CNI - Run $run"
    ./knb -fd $RESULT_FILE_PREFIX.knbdata -o ibdbench -f $RESULT_FILE_PREFIX.tsv
    ./knb -fd $RESULT_FILE_PREFIX.knbdata
done

# Checking Network policies implementation
./netpol.sh > $RESULT_PREFIX.networkpolicies.txt

# Deploy nodes with CNI
./setup.sh -m a11 -w a12,a13 -r
