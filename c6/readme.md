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

