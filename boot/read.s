bits 16
org 0x7c00


mov [BOOT_DRIVE],dl

start:
    mov bp,0x8000
    mov sp,bp
    jmp main

readSectors:
    push dx
    mov ah,0x02 
    mov al,dh       ; set no of sectors to read
    mov ch,0x0      ; cylinder -> 0
    mov dh,0x0      ; head -> 0
    mov cl,0x2        ; read from second sector
    int 0x13

    jc disk_error
    pop dx
    cmp dh,al
    jne disk_error
    jmp end

disk_error:
    mov si,ERROR_MSG
    call print_string
    ret

end:
    mov si,SUCCESS_MSG
    call print_string
    ret

print_string:
    pusha
    mov ah,0x0e
.loop:
    lodsb
    cmp al,0x0
    je .done
    int 0x10
    jmp .loop
.done:
    popa
    ret


printCheck:
    mov si,LOAD_CORRECT
    call print_string
    jmp die

main:
    mov bx,0x9000
    mov dh,3
    
    mov dl,[BOOT_DRIVE]
    call readSectors
    mov dx,[0x9000 + 512]

    cmp dx,0xface
    je printCheck

die:
    cli
    hlt

SUCCESS_MSG db "Finished loading sectors from disk",0xa,0x0d,0
ERROR_MSG db "Unable to load from disk",0xa,0x0d,0
BOOT_DRIVE: db 0
LOAD_CORRECT: db "Value at 0x9000 is 0xdada",0xa,0x0d,0

times 510 -($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
