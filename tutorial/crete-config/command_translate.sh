#!/bin/sh
SVN_TRUNK='/home/chenbo/crete/build/bin'

# # #
CRETEPATH=$SVN_TRUNK
echo $CRETEPATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost

# ========================
rm *.bc
rm *.log
`$CRETEPATH/crete-llvm-translator-qemu-2.3-i386 &> llvm_translate.log`
mv dump_llvm_offline.bc run.bc
