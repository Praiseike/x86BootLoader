# Author: Praise Ike
# Email: Praiseike123@gmail.com


# This is kind of useless now


.func print_string32
.code32
print_string32:
	pusha
	mov edx,0xb8000     

print_string32_loop:
        lodsb
	cmp al,0
        je print_string32_done
	mov ah,0x0f
        mov [edx],ax
	add edx,2
	jmp print_string32_loop

print_string32_done:
	popa
	ret
.endfunc
