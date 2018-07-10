#!/bin/sh
CRETE_DEV='/home/crete/crete-build/bin'

CRETEPATH=$CRETE_DEV

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost

# ========================
rm vm-node/vm/1/hostfile/*
$CRETEPATH/crete-vm-node -c ./crete.vm-node.xml


