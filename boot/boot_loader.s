.code16
.intel_syntax noprefix

.text
.org 0x0


.global _start
_start:
    mov [BOOT_DRIVE],dl

    mov ax,0x2401
    int 0x15

    mov bp,0x8000
    mov sp,bp
    jmp boot

    .include "function_defs.s"
    .include "macro_defs.s"


boot:
    
    lea si,LOADING_OS
    call PrintString
    ReadDisk
    SetupGDT
    SetupIDT
    LoadDescriptorTables
    SwitchToPm
    PerformFarJump
    SetupSegments
    jmp 0x9000


LOADING_OS: .asciz "Loading OS Please Wait...\r\n"
.lcomm BOOT_DRIVE,4
.fill (510-(.-_start)),1,0      # pad with zeroes
boot_magic: .int 0xAA55         # boot magik

.code32
init_pm:
    .include "second_stage.s"
    cli
    hlt
