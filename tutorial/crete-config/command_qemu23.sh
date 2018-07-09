#!/bin/sh
SVN_TRUNK='/home/chenbo/crete/build/bin'

# # #
CRETEPATH=$SVN_TRUNK
echo $CRETEPATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost

IMG='crete.img'
PORT='1234'
MEM_SIZE='256'

# COMM_CMD="-hda $IMG -k en-us -monitor telnet:127.0.0.1:$PORT,server,nowait \
#           -net nic,model=virtio -net nic,model=e1000 -net user "

COMM_CMD="-hda $IMG -k en-us -monitor telnet:127.0.0.1:$PORT,server,nowait"


# =========================
rm tb-ir.txt dbg-tb-ir.txt
rm hostfile/*
# echo "$CRETEPATH/crete-qemu-2.3-system-i386 $COMM_CMD -m $MEM_SIZE -loadvm test  &> qemu_log.txt"
`$CRETEPATH/crete-qemu-2.3-system-i386 $COMM_CMD -m $MEM_SIZE -loadvm test  &> qemu_log.txt`

## Minor guest change: native qemu with loadvm
# `/home/chenbo/tools/qemu-native/qemu-2.3/qemu/i386-softmmu/crete-native-qemu-system-i386 $COMM_CMD -m $MEM_SIZE -loadvm test  &> qemu_log.txt`


## without loadvm: native qemu to save vm
# `/home/chenbo/tools/qemu-native/qemu-2.3/qemu/i386-softmmu/crete-native-qemu-system-i386 $COMM_CMD -m $MEM_SIZE  &> qemu_log.txt`

## kvm-qemu ##
# echo "$COMM_CMD -m 2048 -enable-kvm -smp 8"
# /home/chenbo/tools/qemu-native/qemu-2.3/qemu/i386-softmmu/crete-native-qemu-system-i386 $COMM_CMD -m 2048 -enable-kvm -smp 8  &

# /home/chenbo/tools/qemu-native/qemu-2.3/qemu/i386-softmmu/crete-native-qemu-system-i386 $COMM_CMD -m 2048 -enable-kvm -smp 8 -loadvm test &

### ==========================================
# LD_LIBRARY_PATH=/usr/lib/valgrind/:$LD_LIBRARY_PATH /usr/local/bin/valgrind \
#                --tool=massif \
#                $CRETEPATH/crete-qemu-2.3-system-i386 -nographic $COMM_CMD -m 256 -loadvm test  &> qemu_valgrind_log.txt

# LD_LIBRARY_PATH=/usr/lib/valgrind/:$LD_LIBRARY_PATH /usr/local/bin/valgrind \
#     -v \
#     --error-limit=no \
#     --num-callers=40 \
#     --fullpath-after= \
#     --track-origins=yes \
#     --log-file=./valgrind.log \
#     --leak-check=full \
#     --show-reachable=yes \
#     --vex-iropt-register-updates=allregs-at-mem-access \
#     $CRETEPATH/crete-qemu-2.3-system-i386 $COMM_CMD -m 256 -loadvm test
