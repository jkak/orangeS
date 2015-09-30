# chapter 4

## part a: boot disk with FAT12

```bash

mkdir c4/a/ && cd c4/a/

cp -v ../../c3/b/bochsrc .
cp -v ../../c3/b/freedos.img .
cp -v ../../c3/b/makefile    .
ln -snf ../fat12/pm.img      .

# copy chapter4/a/boot.asm  

make src=boot.asm

bochs
```

运行结果：

![c4_a_boot](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c4/a/c4_a_boot.png)



## part b: search Loader

```bash

mkdir c4/b/ && cd c4/b/

ln -snf ../fat12/pm.img .
cp ../a/bochsrc     .
# 修改bochsrc文件，交换floppya与floppyb，使得从pm.img直接启动
```

copy boot.asm, loader.asm makefile from chapter4/b/
其中，搜索loader.bin文件的函数流程图如下：

![c4_b_loader](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c4/b/c4_b1_searchLoader.png)

```bash
make 
# 更新pm.img，且pm.img是基于../fat12/pm.img的。
# 故该映像内除了make时中入的loader.bin外，之前已经有几个文件了。

xxd  -a -g 1  -s +0x2600 -l 512 pm.img
# 0002740: 4c 4f 41 44 45 52 20 20 42 49 4e 20 00 64 59 b0  LOADER  BIN .dY.
# 0002750: 3d 47 3d 47 00 00 59 b0 3d 47 0d 00 0f 00 00 00  =G=G..Y.=G......
# 可以看到，loader.bin是在文件的2740地址处。相对于根目录区的偏移是0x140h

bochs
# 因为修改了bochsrc文件，直接从pm.img启动，
# 按照书上的步骤调试。可得如下截图。上面通过xxd已经确认loader.bin的偏移位置在0x140h，
# 故加入内存后，其FAT项的首地址是0x90000h + 0x100h + 0x140h = 0x90240h
# 从截图可以看到，当查找到loader.bin时，ES:DI指向文件名后的字节，即0x9024Bh。

```

运行结果：

![c4_b_loader](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c4/b/c4_b_loader.png)



## part c: load Loader

```bash

mkdir c4/c/ && cd c4/c/

ln -snf ../fat12/pm.img .
ln -snf ../b/bochsrc    .
ln -snf ../b/makefile   .

# copy boot.asm, loader.asm makefile from chapter4/c/
# 注意，此处源代码在编译时，有两处都存在一行代码被丢弃掉了。
# 已经在该行后注释NOTE，并且其前后数行全部重新录入了。
# 导致对dispStr和重复读取fatentry相关代码做过单步调试。
# 具体包括: LABEL_GOON_LOADING_FILE标签下数行，以及DispStr函数

make 

bochs
# 因为修改了bochsrc文件，直接从pm.img启动，

```

运行结果：

![c4_c1_loader](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c4/c/c4_c1_loader.png)


