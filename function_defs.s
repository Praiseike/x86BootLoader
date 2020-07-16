.func PrintString
    PrintString:
        lodsb
        mov ah,0x0e
        mov bx,9
        or al,al
        jz .PrintString_done
        int 0x10
        jmp PrintString
    .PrintString_done:
        retw
.endfunc

