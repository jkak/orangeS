
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
nasm  pmtest1b.asm  -o pmtest1b.com

# copy pmtest1b.com to pm.img
sudo mount -o loop pm.img  /mnt/floppy
sudo cp pmtest1b.com  /mnt/floppy/
sudo umount   /mnt/floppy/

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

![c3_1_gdt](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/c3_b1.png)



##  part b2: 3.2 保护模式进阶，超越1M内存空间

本次在c3/b/pmtest2.asm中实现读写1M以上内存空间。并实现从保护模式返回到实模式。并最终退出程序，返回到DOS界面。

从保护模式回到实模块，中间经过了一个实模式下的16位代码段，该代码段内所有数据段寄存器都指向一个新的Normal数据段。在该段内，关闭PE标志。并立即退出到实模式的REAL_ENTRY标号。

在实模式内，再恢复段寄存器以及SP指针，并关闭A20地址。再退出程序。回到DOS界面。

编译与执行：
```bash
# compile
nasm pmtest2.asm  -o pmtest2.com

# copy to pm.img
sudo mount -o loop pm.img  /mnt/floppy
sudo cp pmtest2.com   /mnt/floppy
sudo umount  /mnt/floppy

# run
bochs
```
在启动的DOS环境中执行，效果如下图。
```dos
dir b:
b:\pmtest2.com

```

![c3_2_exit_pm](https://raw.githubusercontent.com/jungle85gopy/orangeS/master/c3/c3_b2.png)


