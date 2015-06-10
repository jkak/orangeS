
## note 1
env prepare


```bash
#/usr/bin/env bash

### 1 prepare env for study orangeS

# date 2015.06

### develop tools

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
```

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


```shell

gcc -o hello hello.c `pkg-config --cflags --libs gtk+-2.0`
./hello
# show a new windows. then gtk success


### install bochs

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
# skipping... see at next note of first OS


## peter-bochs, a more useful tools for debug OS.
# see:  http://code.google.com/p/peter-bochs/downloads/list
curl -O http://peter-bochs.googlecode.com/files/peter-bochs-debugger20130922.jar

java -jar peter-bochs-debugger20111224.jar   
# except UnsupportedClassVersionError: com/peterbochs/PeterBochsDebugger
# because my java version is too old("1.6.0_32"), so use lower version


curl -O http://peter-bochs.googlecode.com/files/java -jar peter-bochs-debugger20111224.jar   
# use tips
java -jar peter-bochs-debugger20111224.jar   
java -jar peter-bochs-debugger20111224.jar   bochs -f bochsrc



## add qemu 

apt-get install qemu
# after install, I find the version of qemu is too old. only 1.1.2
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

