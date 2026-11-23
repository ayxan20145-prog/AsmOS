ASM = nasm
LD = ld

ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T linker.ld

BUILD_DIR = build
OBJS = $(BUILD_DIR)/boot.o $(BUILD_DIR)/main.o

ISO_DIR = iso
BOOT_DIR = $(ISO_DIR)/boot
GRUB_DIR = $(BOOT_DIR)/grub

KERNEL = $(BUILD_DIR)/kernel.bin
ISO_KERNEL = $(BOOT_DIR)/kernel.bin

.PHONY: all iso run clean

all: $(ISO_KERNEL) $(GRUB_DIR)/grub.cfg

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(KERNEL): $(OBJS) linker.ld
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

$(ISO_KERNEL): $(KERNEL)
	mkdir -p $(BOOT_DIR)
	cp $(KERNEL) $(ISO_KERNEL)

$(GRUB_DIR)/grub.cfg: grub.cfg
	mkdir -p $(GRUB_DIR)
	cp grub.cfg $@

$(BUILD_DIR)/boot.o: src/boot.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BUILD_DIR)/main.o: src/main.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

iso: all
	grub-mkrescue -o AsmOS.iso $(ISO_DIR)

run: iso
	qemu-system-i386 -cdrom AsmOS.iso

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(ISO_KERNEL)
	rm -rf $(ISO_DIR)
	rm -f AsmOS.iso
