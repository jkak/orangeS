
# chapter 0: build develop env

## 1 basic tools

run as below

```bash
#/usr/bin/env bash

# basic develop tools

# for gcc
apt-get install build-essential 

# for debug in bochs 
apt-get install xorg-dev libgtk2.0-dev
apt-get install pkg-config

# assembly of nasm 
apt-get install nasm

## test for above
pkg-config --modversion gtk+-2.0
# 2.24.10

pkg-config --list-all | grep gtk
# gtk+-unix-print-2.0    GTK+ - GTK+ Unix print support
# gtk+-x11-2.0           GTK+ - GTK+ Graphical UI Library (x11 arget)
# gtk+-2.0               GTK+ - GTK+ Graphical UI Library (x11 target)


# test gtk
vi hello.c
# code as below

# test like :
gcc -o hello hello.c `pkg-config --cflags --libs gtk+-2.0`
./hello
# show a new windows. then gtk success


```

C test code:

```C
include <gtk/gtk.h>
int main(int argc, char* argv[])
{
   GtkWidget* window;
   GtkWidget* label;

   gtk_init(&argc, &argv);
   window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
   label = gtk_label_new("Hello World.");
   gtk_container_add(GTK_CONTAINER(window), label);
   gtk_widget_show_all(window);
   gtk_main();
   return 0;
}
```

## 2 install bochs 

### 2.1 bochs

run as below

```shell

# download bochs
# http://sourceforge.net/projects/bochs/files/bochs/2.6.8/bochs-2.6.8.tar.gz

cd ~/Download/
tar zxvf bochs-2.6.8.tar.gz
cd bochs-2.6.8

# configure with debug 
./configure  --enable-debugger --enable-disasm
make 
sudo make install 

## bochs env path
/usr/local/share/bochs/

## bochs doc path
 /usr/local/share/doc/bochs/
# bochs bin path
/usr/local/bin/bochs

# bochs config 
# as below. 
```

### 2.2 gen bochs configure file: bochsrc

vim a file named bochsrc as config for bochs. code as below:

```bash
### bochsrc file content:

###################################################
#
# Configuration file for Bochs 
# with NEW Style
# 2015.06.09
#
###################################################

# how much memory the emulated machine will have
megs: 32

# filename of ROM images
romimage:    file=$BXSHARE/BIOS-bochs-latest
vgaromimage: file=$BXSHARE/VGABIOS-lgpl-latest

# what disk images will be used
floppya: 1_44=a.img, status=inserted

# choose the boot disk.
boot: floppy

# where do we send log messages?
log: /tmp/bochs_log.txt

# disable the mouse
mouse: enabled=0

# enable key mapping, using US layout as default.
keyboard: type=mf, serial_delay=200, paste_delay=100000
keyboard: keymap=$BXSHARE/keymaps/x11-pc-us.map
keyboard: user_shortcut=ctrl-alt-del

```

### 2.3 可选项：peter-bochs

peter-bochs可用于增强调试功能。

```bash
## peter-bochs, a more useful tools for debug OS.
# see:  http://code.google.com/p/peter-bochs/downloads/list

curl -O http://peter-bochs.googlecode.com/files/peter-bochs-debugger20130922.jar

java -jar peter-bochs-debugger20111224.jar   
# except UnsupportedClassVersionError: com/peterbochs/PeterBochsDebugger
# because my java version is too old("1.6.0_32"), so use lower version
# so lazy to update java.

# download again 
curl -O http://peter-bochs.googlecode.com/files/java -jar peter-bochs-debugger20111224.jar   

# use tips
java -jar peter-bochs-debugger20111224.jar   
# You will see info looks like: 
# In Linux : java -jar peter-bochs-debugger.jar bochs -f bochxrc.bxrc
# In windows : java -jar peter-bochs-debugger.jar \
#               c:\program files\bochs2.4.3\bochsdbg.exe -q -f bochxrc.bxrc

# after you debug code, use jar as below:
java -jar peter-bochs-debugger20111224.jar   bochs -f bochsrc
```

## 3 install qemu 

install qemu as below

```bash

# apt-get install qemu

# after install as above, I find the version of qemu is too old. only 1.1.2
# so remove it. and get the source code.

curl -O http://wiki.qemu-project.org/download/qemu-2.3.0.tar.bz2
tar -jxvf qemu-2.3.0.tar.bz2
cd qemu-2.3.0
./configure  
make
sudo make install
# also, you can refer   
#   http://en.wikibooks.org/wiki/QEMU/Linux

# bin path
/usr/local/bin/qemu*

## finished env at 2015.06
```


