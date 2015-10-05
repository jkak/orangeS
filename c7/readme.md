# chapter 7 输入输出系统

## part a: 键盘初体验

```bash
mkdir c7/ && cd c7/

# copy files from chapter7/a/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```



