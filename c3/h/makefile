##################################################
# Makefile of pmtestx.asm (x=[1,2,3...])
#
# $@ : object file
# $< : first dependent file
# $^ :   all dependent files
#
##################################################

src:=pmtest8.asm
bin:=$(subst .asm,.com,$(src) )

.PHONY : mount_asm

mount_asm: $(bin)
	sudo mount -o loop pm.img /mnt/floppy/
	sudo cp $(bin) /mnt/floppy/ -v
	sudo umount /mnt/floppy

$(bin) : $(src)
	nasm $< -o $@

clean:
	rm -vf $(bin)
