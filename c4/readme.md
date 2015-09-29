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


