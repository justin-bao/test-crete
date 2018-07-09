#!/bin/sh
cp ../dump_* .
rm klee_time.log

SVN_TRUNK='/home/chenbo/crete/build/bin'

ulimit -c unlimited

# # #
CRETEPATH=$SVN_TRUNK
echo $CRETEPATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost:/home/chenbo/tools/gperftools/.libs

## run klee
`time $CRETEPATH/crete-klee-1.4.0 \
     --search=dfs \
     --check-overshift=false \
     --use-cex-cache \
     --use-forked-solver  \
     --simplify-sym-indices \
     --max-instruction-time=15. \
     --max-memory=2000 \
     run.bc &> concolic.log`

# -debug-print-instrucitons=all:stderr \
    # --max-time=150. \


## valgrind

# LD_LIBRARY_PATH=/usr/lib/valgrind/:$LD_LIBRARY_PATH /usr/local/bin/valgrind \
#                --tool=callgrind \
#                $CRETEPATH/crete-klee-1.3.0 \
#                --max-memory=1000 \
#                --disable-inlining  \
#                --use-forked-solver  \
#                --max-sym-array-size=4096 \
#                -randomize-fork=false \
#                -search=dfs \
#                -max-time=150 \
#                -check-overshift=false \
#                run.bc &> klee_valgrind_log.txt

## gperf
# CPUPROFILE=klee.prof CPUPROFILE_FREQUENCY=50 \
#           $CRETEPATH/crete-klee-1.3.0 \
#           --max-memory=1000 \
#           --disable-inlining  \
#           --use-forked-solver  \
#           --max-sym-array-size=4096 \
#           -randomize-fork=false \
#           -search=dfs \
#           --max-time=30. \
#           -check-overshift=false \
#           run.bc &> klee_valgrind_log.txt
