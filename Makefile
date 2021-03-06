# Author: Praise Ike
# Email: Praiseike123@gmail.com

kernel.img: boot_loader.bin create_junk 
	dd if=/dev/zero of=kernel.img count=16 bs=512
	dd if=boot/boot_loader.bin of=kernel.img conv=notrunc

boot_loader.bin : boot_loader.o kernel.o
	ld -o boot/boot_loader.bin -Ttext 0x7c00 --oformat binary $^

kernel.o : kernel/kernel.c
	gcc -ffreestanding -c $< -o $@

boot_loader.o : boot/boot_loader.s
	as boot/boot_loader.s -o boot_loader.o -I boot

create_junk: create_junk.c
	gcc -o create_junk create_junk.c
clean:
	rm boot/*.bin
	rm *.o
	
