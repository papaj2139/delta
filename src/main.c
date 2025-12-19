#include <types.h>

#include <arch/amd64/drivers/serial.h>

int main() {
    serial_init();
    serial_write("\x1b[2J\x1b[HHello, world!\n");
    while (1);
    return 0;
}