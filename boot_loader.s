.code16
.intel_syntax noprefix
.text
.org 0x0



.global main
main:
    jmp start

    .include "function_defs.s"
    .include "macro_defs.s"

start:
    lea si,msg
    call PrintString
    lea si,loading_os
    call PrintString
    SetupGDT
    SetupIDT
    LoadDescriptorTables
    SwitchToPm
    PerformFarJump
    SetupSegments
    
    jmp .

# Program data

msg: .asciz "Welcome to my bootLoader\r\n"
loading_os: .asciz "Loading OS Please wait..."

.fill (510-(.-main)),1,0
bootMagik: .int 0xAA55

