# chapter 7 输入输出系统

## part a: 键盘初体验

```bash
mkdir c7/a/ && cd c7/a/

# copy files from chapter7/a/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

## part b: 键盘scan code

```bash
mkdir c7/b/ && cd c7/b/

# copy files from chapter7/b/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```

## part c: keyboard_read() finished

```bash
mkdir c7/c/ && cd c7/c/

# copy files from chapter7/c/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```

