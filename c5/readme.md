
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




