
## note 3 protect mode

running os first

### a protect mode os showing
assume that:

* a.img for bochs
* qemu.img for qemu

```shell
mkdir chapter3/
vi chapter3/pm.inc
vi chapter3/pm_test1.asm
# pm_test.asm include "chapter3/pm.inc"

nasm chapter3/pm_test1.asm -o boot.bin

ls -l boot.bin
# 149 bytes only

# for create black 1.44M floppy image file a.img, 1474560 Bytes
bximage

# write boot.bin to a.img
dd if=boot.bin of=a.img bs=512 count=1 conv=notrunc

bochs -f bochsrc
# after running, the screen like the first OS.
# the 12 row 79 column has a red char: 'P'
# P is write to video Memory at SEG_CODE32


```
### use qemu again

```shell
# the below 2 cmd has finished at chapter 1 and 2
#    qemu-img  create -f qcow2 qemu.img 1474560
#    dd if=boot.bin of=qemu.img bs=512 count=1 conv=notrunc

qemu-system-i386 -fda qemu.img
# it works like bochs.
# boot.bin for current chapter has no '55AA'
# so qemu.img based on previous chapter, if you create a new
# qemu.img, it works with error of no bootable device.

```

now, what's GDT?



