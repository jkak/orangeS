##################################################
# Makefile
# #
# $@ : object file
# $< : first dependent file
# $^ :   all dependent files
# 
##################################################

BOOT:=boot.asm
LODR:=loader.asm
BOOT_BIN:=$(subst .asm,.bin,$(BOOT))
LODR_BIN:=$(subst .asm,.bin,$(LODR))

.PHONY : everything

everything : $(BOOT_BIN) $(LODR_BIN)
	# pm.img中有之前的文件
	dd if=$(BOOT_BIN) of=pm.img bs=512 count=1 conv=notrunc
	sudo mount -o loop   pm.img /mnt/floppy/
	sudo   cp  -v  $(LODR_BIN)  /mnt/floppy/ 
	sudo umount /mnt/floppy/

clean :
	rm -f $(BOOT_BIN) $(LODR_BIN)

$(BOOT_BIN) : $(BOOT)
	nasm $< -o $@

$(LODR_BIN) : $(LODR)
	nasm $< -o $@

