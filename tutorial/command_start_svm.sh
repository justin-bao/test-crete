#!/bin/sh
CRETE_DEV='/home/crete/crete-build/bin'
CRETEPATH=$CRETE_DEV

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost

$CRETEPATH/crete-svm-node -c crete.svm-node.xml

