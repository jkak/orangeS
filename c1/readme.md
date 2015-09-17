
## note 2
first os within 20 lines.

### asm

```shell

mkdir chapter1
vi chapter1/boot.asm
# code as book


## gen bochs configure file
vi bochsrc
# code as below
```

### bochsrc file content:


```

###################################################
#
# Configuration file for Bochs 
# with NEW Style
# 2015.06.09
#
###################################################

# how much memory the emulated machine will have
megs: 32

# filename of ROM images
romimage:    file=$BXSHARE/BIOS-bochs-latest
vgaromimage: file=$BXSHARE/VGABIOS-lgpl-latest

# what disk images will be used
floppya: 1_44=a.img, status=inserted

# choose the boot disk.
boot: floppy

# where do we send log messages?
log: log.txt

# disable the mouse
mouse: enabled=0

# enable key mapping, using US layout as default.
keyboard: type=mf, serial_delay=200, paste_delay=100000
keyboard: keymap=$BXSHARE/keymaps/x11-pc-us.map
keyboard: user_shortcut=ctrl-alt-del

```

### compiling the asm to floppy image


```shell

# compile to binary
nasm -f bin chapter1/boot.asm  -o boot.bin

# check the binary file
hexdump boot.bin

# gen 'virtual' floppy disk image.
bximage     # --> enter
# then under the interactive env
1           # create new floppy or hard disk image
fd          # floppy
[1.44MB]    # --> enter
[a.image]   # --> enter, image file name


ls -l  a.out
# -rw-r----- 1 jiang jiang 1474560 6月   9 22:43 a.img
ls -lh a.out

# write boot.bin to the begin 512 Byte at a.img
dd if=boot.bin of=a.img bs=512 count=1 conv=notrunc
```

### run and debug os with bochs

```shell

bochs  -f bochsrc

# Please choose one: [6]    # <ENTER>
# 00000000000i[      ] installing x module as the Bochs GUI
# 00000000000i[      ] using log file log.txt
# Next at t=0
# (0) [0x0000fffffff0] f000:fff0 (unk. ctxt): jmpf 0xf000:e05b          ; ea5be000f0
# <bochs:1> c

    # ENTER
c   # ENTER


```

now the os running success! screen like this:

![first_os_logo_bochs](https://github.com/jungle85gopy/orangeS/blob/master/pic/first_OS_bochs.png)

### run first os on qemu

```shell

# create blank floppy disk image
qemu-img  create -f qcow2 test.img 1474560
# Formatting 'test.img', fmt=qcow2 size=1474560 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16

# use boot.bin to rewrite the first 512 byte of test.img
dd if=boot.bin of=test.img bs=512 count=1 conv=notrunc

# run it
qemu-system-i386 -fda test.img

```

now the os running success! screen like this:

![first_os_logo_qemu](https://github.com/jungle85gopy/orangeS/blob/master/pic/first_OS_qemu.png)


## some tips for chapter 1 and 2

### about dd: copy and convert file

```shell
# example: back up MBR
sudo dd if=/dev/sda of=~/mbr.backup bs=512 count=1

# recovery MBR
sudo dd if=~/mbr.backup of=/dev/sda bs=512 count=1

# recovery formatting table of MBR
sudo dd if=~/mbr.backup of=/dev/sda bs=1 count=66 seek=446

### vim binary file
vim -b mbr.backup
:%!xxd      # input at cmd mode, the data show in hex style
# now you can modiy the binary data
:%!xxd -r   # return to binary mode from hex.
:wq
```

### vim -b  vs  hexdump

```shell

vim -b boot.bin
:%!xxd
# 0000000: 8cc8 8ed8 8ec0 e802 00eb feb8 1e7c 89c5  .............|..
# 0000010: b910 00b8 0113 bb0c 00b2 00cd 10c3 4865  ..............He
# 0000020: 6c6c 6f2c 204f 5320 776f 726c 6421 0000  llo, OS world!..
# ...
# 00001f0: 0000 0000 0000 0000 0000 0000 0000 55aa  ..............U.

# the last 2 lines of hexdump
hexdump boot.bin 
# 0000000 c88c d88e c08e 02e8 eb00 b8fe 7c1e c589
# ...
# 00001f0 0000 0000 0000 0000 0000 0000 0000 aa55
# 0000200
```
the end flag of MBR is 0X55AA. 
sector[510] == 0X55.    # low  byte
sector[511] == 0XAA,    # high byte
also see the 'Hello,', 'world' in boot.bin under **vim**. WORD: '6f2c' -> 'o,'; '776f' -> 'wo',

so, under the vim -b and xxd cmd, the binary WORD data is sequenced by location. but the high byte adead the lower byte.

```shell
# if you want hexdump sequnce like vim -b. use option below:
hexdump boot.bin -e '8/1 "%02X " "\t" "\n"'

```

### Disassembler(反汇编器)
from binary to asm

```shell
ndisasm -o 0x7c00 boot.bin >> disboot.asm
# from boot.asm --> boot.bin  --> disboot.asm
# learn boot.asm from disboot


```



