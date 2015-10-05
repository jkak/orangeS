# chapter 6 Process

## part a: run TestA func

```bash
mkdir c6/a/ && cd c6/a/

# copy files from chapter6/a/

make image

bochs

```

内核内存分布

![c6_a_mem](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c6/a/c6_a_mem.png)

程序流程图

![c6_a_flow](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c6/a/c6_a_flow.png)

执行效果

![c6_a_testa](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c6/a/c6_a_testa.png)



## part b: open interrupt


```bash
mkdir c6/b/ && cd c6/b/

# copy files from chapter6/b/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make final

bochs

```

此段重点要梳理清楚中断前后堆栈指针分别指向何处。


## part c: 中断重入


```bash
mkdir c6/c/ && cd c6/c/

# copy files from chapter6/c/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make stage3

bochs

```

这一部分改动比较小。


## part d: prepare for multi-process


```bash
mkdir c6/d/ && cd c6/d/

# copy files from chapter6/d/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```


## part e: prepare for multi-process


```bash
mkdir c6/e/ && cd c6/e/

# copy files from chapter6/e/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```



## part f: summary of multi-process(add TestC)


```bash
mkdir c6/f/ && cd c6/f/

# copy files from chapter6/f/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```


## part g: modify hwint00 handler

```bash
mkdir c6/g/ && cd c6/g/

# copy files from chapter6/g/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```



## part h: separate restart() from hwint00 handler

```bash
mkdir c6/h/ && cd c6/h/

# copy files from chapter6/h/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

## part k: finish reorganize hwint00 handler

省略中间的i, j两个部分。

```bash
mkdir c6/k/ && cd c6/k/

# copy files from chapter6/k/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

## part l: add black int 0x90 system call

省略中间的i, j两个部分。

```bash
mkdir c6/l/ && cd c6/l/

# copy files from chapter6/l/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

## part n: milli_delay 

省略中间的m部分。

```bash
mkdir c6/n/ && cd c6/n/

# copy files from chapter6/n/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify lib/klib.c， 10 -> 100 in for
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

## part o: milli_delay()


```bash
mkdir c6/o/ && cd c6/o/

# copy files from chapter6/o/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

## part p: begin to schedule()


```bash
mkdir c6/p/ && cd c6/p/

# copy files from chapter6/p/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

## part r: finish schedule()

省略中间的q部分。至此完成简单的优先级调度。

```bash
mkdir c6/r/ && cd c6/r/

# copy files from chapter6/r/

# update a.img bochsrc boot/include/pm.inc by c6/a/
# modify Makefile, add -m32 for CFLAGS, -m elf_i386 for LDFLAGS

make image

bochs

```

第六章结束时，进程相关流程图及内存状态如下二图。

内存分布图：

![c6_r_mem](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c6/r/c6_r_mem_schedule.png)

流程图：

![c6_r_flow](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c6/r/c6_r_flow_schedule.png)

