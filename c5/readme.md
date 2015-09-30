
# chapter 5

## part a: hello in linux with ASM

```bash

mkdir -p c5/a/ && cd c5/a/
# copy code chapter5/a/hello.asm

nasm  -f elf hello.asm  -o hello.o

ld -s hello.o  -o hella
# error:
# ld: i386 architecture of input file  hello.o is incompatible with i386:x86-64 output

ld -m elf_i386  -s hello.o  -o hello
./hello
# hello, world!

```


## part b: 汇编与C同步使用

```bash
mkdir -p c5/b/ && cd c5/b/

# copy bar.c foo.asm from chapter5/b/

nasm -f elf foo.asm -o foo.o 
gcc -c -o bar.o bar.c 
ld -s -o foobar foo.o bar.o 
#ld: i386 architecture of input file foo.o is incompatible with i386:x86-64 output

gcc -m32    -c -o bar.o bar.c 
ld  -m elf_i386 -s -o foobar foo.o bar.o 

./foobar
# the 2nd one


```

关于上面的错误，参考[C与汇编混合编程](http://www.cnblogs.com/chenchenluo/archive/2012/04/02/2421457.html)


## part b1: ELF格式

ELF文件结构如下：

|    ELF Header     |
|    :--------:     | 
| program header 0  | 
| program header 1  |
|      ....         | 
|     section  0    | 
|     section  1    | 
|      ....         | 
| section header 0  |
| section header 1  |
|      ....         | 

### ELF Header

foobar的ELF数据
```bash
xxd  -a -g 1  -l 80 foobar 
0000000: 7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00  .ELF............
0000010: 02 00 03 00 01 00 00 00 a0 80 04 08 34 00 00 00  ............4...
0000020: c4 01 00 00 00 00 00 00 34 00 20 00 03 00 28 00  ........4. ...(.
0000030: 07 00 06 00  01 00 00 00 00 00 00 00 00 80 04 08  ................
0000040: 00 80 04 08 6c 01 00 00 6c 01 00 00 05 00 00 00  ....l...l.......
```
格式与说明
```c
#define EI_NIDENT   16

# name          Bytes   # func
# elf32_addr    4       address
# elf32_off     4       offset
# elf32_word    4       big int
# elf32_half    2           int
# unsigned char 1       little int

# 最后的注释，是foobar的相应赋值
typedef struct {
    unsigend char   e_ident[EI_NIDENT]; # 前16个字节，1-3是ELF
    elf32_half      e_type;      # 文件类型；0002；表示可执行文件
    elf32_half      e_machine;   # CPU体系结构；0003 ；表示80i386
    elf32_word      e_version;   # 程序版本；00000001
    elf32_addr      e_entry;     # 程序入口地址；080480A0
    elf32_off       e_phoff;     # program header offset(Bytes); 00000034
    elf32_off       e_shoff;     # section header offset(Bytes); 000001C4
    elf32_word      e_flags;     # flags? ; 00000000
    elf32_half      e_ehsize;    # ELF Header size; 0034
    elf32_half      e_phentsize; # size of program header; 0020
    elf32_half      e_phnum;     #  num of program header; 0003
    elf32_half      e_shentsize; # size of program header; 0028
    elf32_half      e_shnum;     #  num of program header; 0007
    elf32_half      e_shstrndx;  # section header name in which sec; 0006
} elf32_ehdr;
```

从上面可知，ELF Header占用了0x34个字节。其后即是program header table。 program header的每一项如上可见，占用0x20个字节。它描述系统为准备程序运行所需要的段中其他信息。如e_phnum所示，此处有3项。

### Program Header
三个program header数据。
```bash
xxd  -a -g 1 -s 0x34  -l 0x60 foobar 
0000034: 01 00 00 00  00 00 00 00  00 80 04 08  00 80 04 08  
0000044: 6c 01 00 00  6c 01 00 00  05 00 00 00  00 10 00 00 

0000054: 01 00 00 00  6c 01 00 00  6c 91 04 08  6c 91 04 08  
0000064: 08 00 00 00  08 00 00 00  06 00 00 00  00 10 00 00  

0000074: 51 e5 74 64  00 00 00 00  00 00 00 00  00 00 00 00  
0000084: 00 00 00 00  00 00 00 00  07 00 00 00  04 00 00 00  
```

格式。以下全是4字节为单位。

```c
typedef struc {
    elf32_word      p_type;      # 段类型；
    elf32_off       p_offset;    # 段的首字节在文件中的偏移
    elf32_addr      p_vaddr;     # 段的首字节在内存的虚拟地址
    elf32_addr      p_paddr;     # 段的首字节在内存的物理地址
    elf32_word      e_ffilesz;   # 段在文件中的长度
    elf32_word      e_memsz;     # 段在内存中的长度
    elf32_word      e_flags;     # 段相关的标志
    elf32_word      e_align;     # 段在文件及内存中的对齐方式
    
} elf32_phdr;

```
| 名称       | prog header 0 | prog header 1 | prog header 2 |
| --------   |    --------:  |    --------:  |  ----------:  |
| p_type     |  0x00000001   |   0x00000001  | 0x6474E551    |
| p_offset   |  0x0          |   0x0000016C  | 0x0           |
| p_vaddr    |  0x08048000   |   0x0804916C  | 0x0           |
| p_paddr    |  0x08048000   |   0x0804916C  | 0x0           |
| e_ffilesz  |  0x0000016C   |   0x00000008  | 0x0           |
| e_memsz    |  0x0000016C   |   0x00000008  | 0x0           |
| e_flags    |  0x00000005   |   0x00000006  | 0x00000007    |
| e_align    |  0x00001000   |   0x00001000  | 0x00001000    |



