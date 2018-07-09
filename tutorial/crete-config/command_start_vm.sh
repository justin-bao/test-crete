#!/bin/sh
CRETE_DEV='/home/chenbo/crete/build/bin'
CMAKE_INSTALL='/usr/crete-bin'

CRETEPATH=$CRETE_DEV
# CRETEPATH=$CMAKE_INSTALL

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost

# ========================
rm vm-node/vm/1/hostfile/*
$CRETEPATH/crete-vm-node -c ./crete.vm-node.xml

echo $CRETEPATH
