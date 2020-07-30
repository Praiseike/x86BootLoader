kernel.img: boot_loader.bin
	dd if=/dev/zero of=kernel.img count=16 bs=512
	dd if=boot/boot_loader.bin of=kernel.img conv=notrunc

boot_loader.bin : boot_loader.o kernel.o
	ld -o boot/boot_loader.bin -Ttext 0x7c00 --oformat binary $^

kernel.o : kernel/kernel.c
	gcc -ffreestanding -c $< -o $@

boot_loader.o : boot/boot_loader.s
	as boot/boot_loader.s -o boot_loader.o -I boot

clean:
	rm kernel.img
	rm boot/*.bin
	rm *.o
	
