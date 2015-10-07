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

## part d: show char and num of keyboard input

```bash
mkdir c7/d/ && cd c7/d/

# copy files from chapter7/d/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```

## part e: show UPPER char of keyboard input

```bash
mkdir c7/e/ && cd c7/e/

# copy files from chapter7/e/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```

## part f: get PrintScreen and Pause from keyboard input

```bash
mkdir c7/f/ && cd c7/f/

# copy files from chapter7/f/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```


## part g: finish keyboard_read() to read from keyboard input

```bash
mkdir c7/g/ && cd c7/g/

# copy files from chapter7/g/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```
需要注意的是，在最终可以处理输入字符前，又根据当前是否有按下ctrl, alt, shift等键，通过FLAG_SHIFT_L等bit位，或到32位的key中。以方便上层函数知晓输入附加情况。



## part h: begin VGA and tty

```bash
mkdir c7/h/ && cd c7/h/

# copy files from chapter7/h/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```


## part i: finish VGA and tty Framework

```bash
mkdir c7/i/ && cd c7/i/

# copy files from chapter7/i/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```



## part j: switch tty 

```bash
mkdir c7/j/ && cd c7/j/

# copy files from chapter7/j/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```



## part k: scroll screen switch tty 

```bash
mkdir c7/k/ && cd c7/k/

# copy files from chapter7/k/

# update a.img bochsrc boot/include/pm.inc by c7/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS
# modify exec by a script

make image

bochs

```
