
# chapter 3 认识保护模式

## part a

运行如下命令：

```bash

cd c3/a/
cp ../../c1/bochsrc ./
cp ../../c1/a.img   ./
# 因为pmtest1.asm 并没有写成完整的MBR结构，没有结构标志(0xAA00)
# 所以此处不能使用一个空的a.img文件

nasm  pmtest1.asm  -o boot.bin
dd if=boot.bin of=a.img  conv=notrunc

# 此处有个坑，此处使用dd不能加"bs=512 count=1"参数
# 如果加了上述2上参数，则整个mbr的512字节都会被当前的boot.bin
# 给覆盖掉，就没有mbr的结束标志了。 不加则boot.bin有多少个非空字节，
# 就只写入多少个字节。

bochs 
# 如此则可看到右侧中间出现一个红色的字母P。

```
##  part b0: use freedos.img
通过双软驱的形式，使用freedos.img启动软驱A，再从A中运行B中的pmtest.asm。有几件事需要仔细准备。

 * 下载FreeDos，并命名为freedos.img
 * 用bximage生成pm.img软驱文件
 * 格式化pm.img为软盘格式。此处有两个办法。
   * 参考书上，启动bochs，在启动的Freedos A盘中 format b:。
   * 通过mount文件的方式来完成。具体见后面单独附录说明。
 * 根据../a/bochsrc文件，生成新的bochsrc文件，增加书上三行

```bash
vim bochsrc
# has 3 lines as below:
#floppya: 1_44=freedos.img, status=inserted
#floppyb: 1_44=pm.img,      status=inserted
#boot: floppy
```
 * 修改源文件中org 07c00h 为 org 0100h
 * 重新编译如下

```bash
cd c3/b/

# 对asm文件的编译，以及copy到pm.img操作
# 都统一放在makefile中完成
make src=pmtest1b.asm

bochs
# 启动后，进入freedos，即进入A盘。
# 在A盘中执行如下命令。即可执行pmtest1b.com
```
在bochs中启动的freedos中，执行如下dos命令：
```dos
dir b:
b:\pmtest1b.com
# 结果如书上图3.3
```

### 附：新方法格式化pm.img为软盘

```bash
cd c3/b/
# 如果是通过书上的方法格式化的pm.img文件。则其文件格式如下
file  pm.img
# pm.img: DOS floppy 1440k, x86 hard disk boot sector

bximage     # 生成新的pm.img
file pm.img 
# pm.img : data

# 将pm.img当做loop device使用
sudo losetup  /dev/loop0  pm.img

# 格式化
sudo mkfs.msdos /dev/loop0 
# mkfs.msdos 3.0.13 (30 Jun 2012)

sudo fsck.msdos /dev/loop0 
# dosfsck 3.0.13, 30 Jun 2012, FAT32, LFN
# dev/loop0: 0 files, 0/2847 clusters

# 取消挂载
sudo losetup -d /dev/loop0 

file pm.img
#pm.img: DOS floppy 1440k, x86 hard disk boot sector

```


##  part b1: GDT表

GDT表，及段式线性地址转换示意图。

![c3_1_gdt](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/b/c3_b1.png)



##  part b2: 3.2 保护模式进阶，超越1M内存空间

本次在c3/b/pmtest2.asm中实现读写1M以上内存空间。并实现从保护模式返回到实模式。并最终退出程序，返回到DOS界面。

从保护模式回到实模块，中间经过了一个实模式下的16位代码段，该代码段内所有数据段寄存器都指向一个新的Normal数据段。在该段内，关闭PE标志。并立即退出到实模式的REAL_ENTRY标号。

在实模式内，再恢复段寄存器以及SP指针，并关闭A20地址。再退出程序。回到DOS界面。

编译与执行：
```bash
# compile
make src=pmtest2.asm

# run
bochs
```
在启动的DOS环境中执行，效果如下图。
```dos
dir b:
b:\pmtest2.com

```

![c3_2_exit_pm](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/b/c3_b2.png)




##  part c: LDT表
准备环境。
```bash
cd orangeS/c3/ && mkdir c/ && cd c/

ln -snf ../b/bochsrc  ./
ln -snf ../b/freedos.img ./
ln -snf ../b/makefile    ./
ln -snf ../b/pm.img  ./pm.img
ln -snf ../b/pm.inc  ./pm.inc


ls -l
# bochsrc -> ../b/bochsrc
# freedos.img -> ../b/freedos.img
# makefile -> ../b/makefile
# pm.img -> ../b/pm.img
# pm.inc -> ../b/pm.inc

# copy pmtest3.asm from src
```

运行

```bash
# compile
make src=pmtest3.com   

# run as c3/b/
bochs

```

代码调用关系图。

![c3_3_code_call_rel](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/c/c3_c1.png)


## part c1: 修改LDT表

主要是在LDT表中，增加数据段，堆栈段，整体上是模仿实模式下的32位相关段。
代码段也是模仿32位GDT下的代码段。

在LDT下，代码段中，加载数据段和堆栈段，然后从数据段读取数据显示到GDT下的显存段。
编译过程类似上面的步骤。整理如下：


```bash
# compile
make src=pmtest3a.com   

# run 
bochs

```

运行结果

![c3_3_ldt](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/c/c3_c2_ldt_more.png)



##  part d: 特权级之调用门

准备环境。
```bash
cd orangeS/c3/ && mkdir d/ && cd d/

ln -snf ../b/bochsrc  ./
ln -snf ../b/freedos.img ./freedos.img
ln -snf ../b/makefile    ./
ln -snf ../b/pm.img  ./pm.img
ln -snf ../b/pm.inc  ./pm.inc


ls -l
# bochsrc -> ../b/bochsrc
# freedos.img -> ../b/freedos.img
# makefile -> ../b/makefile
# pm.img -> ../b/pm.img
# pm.inc -> ../b/pm.inc

# copy pmtest4.asm from src/chapter3/d/pmtest4.asm
```

运行

```bash
# compile
nasm pmtest4.asm  -o pmtest4.com

# copy to pm.img
sudo mount -o loop pm.img   /mnt/floppy
sudo cp pmtest4.com         /mnt/floppy
sudo umount  /mnt/floppy

# run as c3/c/
bochs

```

增加一个调用门的基本步骤，以及各段程序之间的调用过程。

![c3_d1_gate](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/d/c3_d1_Gate.png)



##  part d: 特权级转移之理论篇

特权级转换时的检查规则，以及相应特权级堆栈间切换的示意图。

![c3_d2_pl](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/d/c3_d2_PL.png)



##  part e1: 特权级转移之进入ring3

准备环境。

```bash
cd orangeS/c3/ && mkdir e/ && cd e/

ln -snf ../b/bochsrc  ./
ln -snf ../b/freedos.img ./freedos.img
ln -snf ../b/makefile    ./
ln -snf ../b/pm.img  ./pm.img
ln -snf ../b/pm.inc  ./pm.inc


ls -l
# bochsrc -> ../b/bochsrc
# freedos.img -> ../b/freedos.img
# makefile -> ../b/makefile
# pm.img -> ../b/pm.img
# pm.inc -> ../b/pm.inc

# copy pmtest5a.asm from src/chapter3/d/pmtest5a.asm
```


运行

```bash
# compile
make src=pmtest5a.asm

# run as c3/c/
bochs

```
注意，在运行bochs之前，一定要umount掉floppy。不然启动之后，
在软驱中可能运行pm.img中的程序不正常。

运行结果：

![c3_ea](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/e/c3_ea.png)



##  part e2: 特权级转移实践

copy pmtest5c.com,然后运行

```bash
# compile
make src=pmtest5c.asm

# run as c3/c/
bochs

```
此时已经可以显示C和3。

再增加从局部任务返回实模式代码。通过pmtest5.com返回。编译类似上述5c.asm。
执行效果如下。


![c3_e5](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/e/c3_e5.png)

此处不明白之处是，ltr加载的TSS，按理应该是属于当前32位保护代码的TSS。
然后通过压栈进入到ring3的。从程序运行来说，这个TSS却是ring3程序的。
通过这个TSS来使用调用门，以达到切换到0号特权栈。

程序调用关系如下。

![c3_e5_rel](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/e/c3_e5_rel.png)


##  part f1: 启动页式内存管理

直接将线性地址空间完全连续映射到页空间。准备环境如下。

```bash
cd orangeS/c3/ && mkdir f/ && cd f/

ln -snf ../b/bochsrc  ./
ln -snf ../b/freedos.img ./freedos.img
ln -snf ../b/makefile    ./
ln -snf ../b/pm.img  ./pm.img

ls -l
# bochsrc -> ../b/bochsrc
# freedos.img -> ../b/freedos.img
# makefile -> ../b/makefile
# pm.img -> ../b/pm.img

# copy pmtest6.asm from src/chapter3/f/pmtest6.asm
# copy pm.inc      from src/chapter3/f/pm.inc
#  因为增加了页属性

```

运行

```bash
# compile
make src=pmtest6.asm  

bochs
```



##  part g1: 克勤克俭用内存

准备环境如下。

```bash
cd orangeS/c3/ && mkdir g/ && cd g/

ln -snf ../b/bochsrc  ./
ln -snf ../b/freedos.img ./freedos.img
ln -snf ../b/makefile    ./
ln -snf ../b/pm.img  ./pm.img

ls -l
# bochsrc -> ../b/bochsrc
# freedos.img -> ../b/freedos.img
# makefile -> ../b/makefile
# pm.img -> ../b/pm.img

# copy pmtest7.asm from src/chapter3/g/pmtest7.asm
# copy lib.inc     from src/chapter3/g/lib.inc
# copy pm.inc      from src/chapter3/g/pm.inc
#  因为增加了flags相关说明。

```

运行

```bash
# compile
make src=pmtest7.asm  

bochs
```

程序执行结果。

![c3_g1_mem](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/g/c3_g1_mem.png)



##  part h: 进一步体会分页机制

准备环境如下。

```bash
cd orangeS/c3/ && mkdir h/ && cd h/

ln -snf ../b/bochsrc  ./
ln -snf ../b/freedos.img ./freedos.img
ln -snf ../b/makefile    ./
ln -snf ../b/pm.img  ./pm.img
# pm.inc from g
ln -snf ../g/pm.inc  ./pm.inc

ls -l
# bochsrc -> ../b/bochsrc
# freedos.img -> ../b/freedos.img
# makefile -> ../b/makefile
# pm.img -> ../b/pm.img
# pm.inc -> ../g/pm.inc

# copy pmtest8.asm from src/chapter3/h/pmtest8.asm
# copy lib.inc     from src/chapter3/h/lib.inc

```

运行

```bash
# compile
make src=pmtest8.asm  

bochs
```

程序执行结果。

![c3_h1](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/h/c3_h1.png)



##  part i1: 中断和异常机制，实现一个中断

省略pmtest9a.asm和pmtest9b.asm程序。仅操作pmtest9c.asm。
准备环境如下。

```bash
cd orangeS/c3/ && mkdir i/ && cd i/

ln -snf ../b/bochsrc  ./
ln -snf ../b/freedos.img ./freedos.img
ln -snf ../b/makefile    ./
ln -snf ../b/pm.img  ./pm.img
ln -snf ../g/pm.inc  ./pm.inc
ln -snf ../h/lib.inc ./lib.inc

ls -l
# bochsrc -> ../b/bochsrc
# freedos.img -> ../b/freedos.img
# makefile -> ../b/makefile
# lib.inc  -> ../h/lib.inc
# pm.img -> ../b/pm.img
# pm.inc -> ../g/pm.inc

# copy pmtest9c.asm from src/chapter3/i/pmtest9c.asm

```

运行

```bash
# compile
make src=pmtest9c.asm  

bochs
```

中断门，陷阱门与中断8259A连接图。

![c2_i1_int](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/i/c3_i1_int.png)



##  part i2: 中断和异常机制，时钟中断

运行命令:
```bash

# copy pmtest9.asm from src/chapter3/i/pmtest9.asm

# compile
make src=pmtest9.asm  

bochs
```

关于中断与陷阱，需要注意两者有个细微的差别。中断时复位掉IF标志，以免中断被打断而引起嵌套。
而陷阱却不会影响IF标志。


