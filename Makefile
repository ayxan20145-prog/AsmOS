ASM = nasm
LD = ld

ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T linker.ld

OBJS = boot.o main.o vga.o

ISO_DIR = iso
BOOT_DIR = $(ISO_DIR)/boot
GRUB_DIR = $(BOOT_DIR)/grub

KERNEL = $(BOOT_DIR)/AsmOS

.PHONY: all iso run clean

all: $(KERNEL) $(GRUB_DIR)/grub.cfg

$(KERNEL): $(OBJS)
	$(LD) $(LDFLAGS) -o AsmOS $^
	mkdir -p $(BOOT_DIR)
	mv AsmOS $(KERNEL)

$(GRUB_DIR)/grub.cfg:
	mkdir -p $(GRUB_DIR)
	cp grub.cfg $(GRUB_DIR)/grub.cfg

boot.o: src/boot.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

main.o: src/main.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

vga.o: src/vga.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

iso: all
	grub-mkrescue -o AsmOS.iso $(ISO_DIR)

run: iso
	qemu-system-i386 -cdrom AsmOS.iso

clean:
	rm -f $(OBJS)
	rm -f $(BOOT_DIR)/AsmOS
	rm -f $(GRUB_DIR)/grub.cfg
	rm -f AsmOS.iso
