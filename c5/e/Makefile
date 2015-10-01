##################################################
# Makefile
##################################################

BOOT:=boot.asm
LODR:=loader.asm
KERNEL:=kernel.asm
BOOT_BIN:=$(subst .asm,.bin,$(BOOT))
LODR_BIN:=$(subst .asm,.bin,$(LODR))
KERNEL_BIN:=$(subst .asm,.bin,$(KERNEL))
KERNEL_OOO:=$(subst .asm,.o,$(KERNEL))

IMG:=a.img
FLOPPY:=/mnt/floppy/

.PHONY : everything

everything : $(BOOT_BIN) $(LODR_BIN) $(KERNEL_BIN)
	dd if=$(BOOT_BIN) of=$(IMG) bs=512 count=1 conv=notrunc
	sudo mount -o loop $(IMG) $(FLOPPY)
	sudo cp $(LODR_BIN) $(FLOPPY) -v
	sudo cp $(KERNEL_BIN) $(FLOPPY) -v
	sudo umount $(FLOPPY)

clean :
	rm -vf $(BOOT_BIN) $(LODR_BIN) $(KERNEL_BIN) *.o

$(BOOT_BIN) : $(BOOT)
	nasm $< -o $@

$(LODR_BIN) : $(LODR)
	nasm $< -o $@

$(KERNEL_BIN) : $(KERNEL)
	nasm -f elf -o 			$(KERNEL_OOO) $<
	ld -m elf_i386 -s -Ttext 0x30400 -o $@ $(KERNEL_OOO)

