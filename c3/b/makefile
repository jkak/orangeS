##################################################
# Makefile of pmtestx.asm (x=[1,2,3...])
#
# $@ : object file
# $< : first dependent file
# $^ :   all dependent files
#
##################################################

src:=
# ',' 之间不能有空格
bin:=$(subst .asm,.com,$(src) )

.PHONY : mount_com

mount_com: $(bin)
	sudo mount -o loop pm.img /mnt/floppy/
	sudo cp $(bin) /mnt/floppy/ -v
	sudo umount /mnt/floppy

$(bin) : $(src)
	nasm $< -o $@

clean:
	rm -vf *.com
