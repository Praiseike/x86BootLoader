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

.func readSectors
    readSectors:
 
            push dx
            mov ah,0x02     # read disk routine
            mov ch,0x0      # cylinder -> 0
            mov al,dh       # no of sectors
            mov dh,0        # head -> 0
            mov cl,0x02     # sector -> 2 : after the boot_sector
            mov dl,[BOOT_DRIVE]     
            int 0x13

            jc disk_error
            pop dx
            cmp dh,al
            jne disk_error
            lea si,SUCCESS_MSG
            call PrintString
	    ret
			 
    disk_error:
        lea si,DISK_ERROR_MSG
        call PrintString
        ret
        
        SUCCESS_MSG: .asciz "Finished Loading sectors successfully: \n\r" 
        DISK_ERROR_MSG: .asciz "Disk Error: Unable to read from disk\n\r"
.endfunc
