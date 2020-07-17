.code16
.intel_syntax noprefix
.text
.org 0x0



.global main
main:
    mov bp,0x8000
    mov sp,bp
    mov [BOOT_DRIVE],dl
    jmp start

    .include "function_defs.s"
    .include "macro_defs.s"

start:
    lea si,[msg]
    call PrintString
    lea si,[loading_os]
    call PrintString
    ReadDisk
    SetupGDT
    SetupIDT
    LoadDescriptorTables
    SwitchToPm
    PerformFarJump
    SetupSegments
    jmp 0x9000 
    cli
    hlt

# Program data

msg: .asciz "Welcome to my bootLoader\r\n"
loading_os: .asciz "Loading OS Please wait...\n\r"
.lcomm BOOT_DRIVE,4
.fill (510-(.-main)),1,0
bootMagik: .int 0xAA55
.include "second_loader.s"
# End of story
