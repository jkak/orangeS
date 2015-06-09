
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
curl http://peter-bochs.googlecode.com/files/peter-bochs-debugger20130922.jar
mv peter-bochs-debugger20130922.jar  peter-bochs-debugger.jar

# use tips
java -jar peter-bochs-debugger.jar -v
java -jar peter-bochs-debugger.jar  bochs  -f  bochsrc

## finished env at 2015.06

```

