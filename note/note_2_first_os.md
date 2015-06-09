
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


# run and debug os
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

![first_os_logo](https://github.com/jungle85gopy/orangeS/blob/master/pic/first_OS.png)





