# === Toolchain Setup ===
CROSS_COMPILE = arm-none-eabi-
AS = $(CROSS_COMPILE)as
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy

# === Flags ===
CFLAGS = -ffreestanding -O2 -Wall
LDFLAGS = -T linker.ld

# === Paths ===
SRC_DIR = src
BUILD_DIR = build

# === Files ===
MAIN_OBJ = $(BUILD_DIR)/main.o
KERNEL_OBJ = $(BUILD_DIR)/kernel.o
KERNEL_ELF = $(BUILD_DIR)/kernel.elf
KERNEL_IMG = $(BUILD_DIR)/kernel.img

# === Build Kernel Image ===
all: $(KERNEL_IMG)

# Assemble bootloader
$(MAIN_OBJ): $(SRC_DIR)/main.s
	$(AS) $< -o $@

# Compile kernel
$(KERNEL_OBJ): $(SRC_DIR)/kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

# Link boot + kernel into ELF
$(KERNEL_ELF): $(MAIN_OBJ) $(KERNEL_OBJ)
	$(LD) $(LDFLAGS) -o $@ $^

# Convert ELF to flat binary
$(KERNEL_IMG): $(KERNEL_ELF)
	$(OBJCOPY) $< -O binary $@

# === Run in QEMU ===
run: all
	qemu-system-arm -kernel $(KERNEL_IMG) -M versatilepb -cpu arm1176 -nographic

# === Clean Build Files ===
clean:
	rm -f $(BUILD_DIR)/*.o $(KERNEL_ELF) $(KERNEL_IMG)
