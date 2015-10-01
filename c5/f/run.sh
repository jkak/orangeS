#!/bin/bash

nasm boot.asm   -o boot.bin
nasm loader.asm -o loader.bin

dd if=boot.bin of=a.img bs=512 count=1 conv=notrunc

nasm -f elf  kernel.asm -o kernel.o 
nasm -f elf  string.asm -o string.o 
nasm -f elf  kliba.asm  -o kliba.o

gcc -m32 -fno-builtin -c -o start.o start.c

# kernel.bin
ld -m elf_i386 -s -Ttext 0x30400 -o kernel.bin kernel.o string.o start.o kliba.o

# mount
sudo mount -o loop a.img /mnt/floppy/
sudo cp -vf loader.bin   /mnt/floppy/
sudo cp -vf kernel.bin   /mnt/floppy/

sudo ls -l  /mnt/floppy
sudo umount /mnt/floppy

