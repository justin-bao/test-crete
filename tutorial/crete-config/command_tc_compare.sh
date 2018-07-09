#!/bin/sh
SVN_TRUNK='/home/chenbo/crete/build/bin'

# # #
CRETEPATH=$SVN_TRUNK
echo $CRETEPATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost:/home/chenbo/tools/gperftools/.libs

## run tc-compare
# $CRETEPATH/crete-tc-compare \
#     -b $1

## run with gperf
time CPUPROFILE=tc.compare.prof CPUPROFILE_FREQUENCY=500 \
     $CRETEPATH/crete-tc-compare \
     -b $1

# $CRETEPATH/crete-tc-compare \
#     -r $1 \
#     -t $2

# `time $CRETEPATH/crete-klee-1.3.0 \
#      --max-memory=1000 \
#      --disable-inlining  \
#      --use-forked-solver  \
#      --max-sym-array-size=4096 \
#      --max-instruction-time=5. \
#      -randomize-fork=false \
#      -search=dfs \
#      -check-overshift=false \
#      --max-time=150. \
#      run.bc &> concolic.log`
