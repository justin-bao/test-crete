ee
#!/bin/sh
SVN_TRUNK='/home/crete/crete-build/bin'

# # #
CRETEPATH=$SVN_TRUNK
echo $CRETEPATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CRETEPATH:/usr/local/lib:$CRETEPATH/boost

#----------------------------
SSHPORT="20014"
#----------------------------

#----------------------------
IMG='crete.img'
#----------------------------

PORT='1236'
MEM_SIZE='2048'

COMPLETE_CMD="-hda $IMG -k en-us -monitor telnet:127.0.0.1:$PORT,server,nowait \
          -redir tcp:$SSHPORT::22 -rtc clock=vm \
          -netdev user,id=net1 -device virtio-net-pci,netdev=net1\
	  -append 'console=ttyS0' \
          -initrd rootfs.cpio.gz \
          -kernel cmdline  \
          -nographic \
          -serial mon:stdio \
          "
## ==============================
echo "$COMPLETE_CMD"

# =========================

rm tb-ir.txt dbg-tb-ir.txt
rm hostfile/*
echo "qemu-system-i386 $COMPLETE_CMD"
#`/home/crete/qemu-2.3.0/x86_64-softmmu/qemu-system-x86_64 $COMPLETE_CMD -m $MEM_SIZE -loadvm test &> qemu_log.txt`
`$CRETEPATH/crete-qemu-2.3-system-x86_64 $COMPLETE_CMD -m $MEM_SIZE -loadvm test &> qemu_log.txt`

## Minor guest change: native qemu with loadvm

# `/home/chenbo/tools/qemu-native/qemu-2.3/x86_64-softmmu/qemu-system-x86_64 $COMPLETE_CMD -m $MEM_SIZE -loadvm test  &> qemu_log.txt`

## without loadvm: native qemu to save vm
# `/home/chenbo/tools/qemu-native/qemu-2.3/x86_64-softmmu/qemu-system-x86_64 $COMPLETE_CMD -m $MEM_SIZE  &> qemu_log.txt`

## kvm-qemu ##
# echo "$COMPLETE_CMD -m 2048 -enable-kvm -smp 8"
# /home/chenbo/tools/qemu-native/qemu-2.3/x86_64-softmmu/qemu-system-x86_64 $COMPLETE_CMD -m 2048 -enable-kvm -smp 4  &


