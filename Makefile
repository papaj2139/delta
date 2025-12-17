ARCH ?= amd64
KERNEL := delta.elf

#toolchain
CC := gcc
NASM := nasm
LD := ld

CFLAGS := -std=c11 -ffreestanding -fno-stack-protector -fno-pic \
          -mno-red-zone -mno-sse -mno-sse2 -mno-mmx \
          -Wall -Wextra -O2 -g

NASMFLAGS := -f elf64 -g

LDFLAGS := -nostdlib -static -T arch/$(ARCH)/linker.ld

ASM_SRCS := arch/$(ARCH)/entry.asm
C_SRCS :=

ASM_OBJS := $(ASM_SRCS:.asm=.o)
C_OBJS := $(C_SRCS:.c=.o)
OBJS := $(ASM_OBJS) $(C_OBJS)

#build kernel
$(KERNEL): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

#compile C sources
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

#assemble assembly sources
%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

.PHONY: all clean

all: $(KERNEL)

clean:
	rm -f $(KERNEL) $(OBJS)
