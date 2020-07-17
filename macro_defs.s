.macro ReadDisk
ReadDisk:

		mov bx,0x9000       # Buffer memory
 		mov dh,2            # No sectors to read
		call readSectors 
.endm

.macro SetupGDT

SetupGDT:
	# points to es:di to right memory section

	mov ax,0
	mov es,ax
	mov di,0x800

	# NULL Descriptor
	mov cx,4    # write the null descriptor
	rep stosw   # which is 4 zero words.

	# code segment
	mov es:[di], word ptr 0xffff        # limit = 0xffff
		                                # since granularity bit
		                                # is set, this is 4G
	mov es:[di+2],word ptr 0x0000       # base = 0x0000
	mov es:[di+4],byte ptr 0x0          # base
	mov es:[di+5],byte ptr 0x9a         # access = 0x9a
	mov es:[di+6],byte ptr 0xcf         # flags + limit = 0xcf
	mov es:[di+7],byte ptr 0x00         # base
	add di,8

	# Data segment descriptor
	mov es:[di],word ptr 0xffff         # limit = oxffff
	mov es:[di+2],word ptr 0x0000       # base = 0x0000
	mov es:[di+4],byte ptr 0x0          # base
	mov es:[di+5],byte ptr 0x92         # access = 0x92
	mov es:[di+6],byte ptr 0xcf         # flags + limit
	mov es:[di+7],byte ptr 0x00         # base
        
	gdt:
		.word 24    # size of GDT in bytes -1
		.int 2048  # Linear address of GDT


.endm


.macro SetupIDT

SetupIDT:
        mov ax,0x000
	mov es,ax
	mov di,0x0
	mov cx,2048
	rep stosb

idt:
    .word  2048  # Size of IDT (256 entries of 8 bytes)
    .int   0x0   # Linear address of IDT

.endm


.macro LoadDescriptorTables
LoadDescriptorTables:
    lgdt gdt
    lidt idt
.endm   	



.macro SwitchToPm
SwitchToPm:
        cli
        mov eax,cr0
	or eax,0x1
	mov cr0,eax

.endm	


.macro PerformFarJump
		jmp 0x8:ClearPipeline 
                nop
		nop
		nop

.code32

ClearPipeline:
    mov eax,0xabc 
.endm

.macro SetupSegments
	mov ax,0x10
	mov es,ax
	mov ds,ax
	mov es,ax
	mov gs,ax
	mov fs,ax
	mov ss,ax
        mov esp,0x90000
.endm
	
