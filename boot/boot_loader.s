# Author: Praise Ike
# Email: Praiseike123@gmail.com

.code16
.intel_syntax noprefix

.text
.org 0x0


.global _start
_start:
    mov [BOOT_DRIVE],dl                 # Store the boot drive from bios

bios_a20:
    mov ax,0x2401                       # Enable the A20 line through a bios routine
    int 0x15
    cmp ah,0x86
    jnc setup_stack                     # jump to setup_stack on success 
                                        # else attempt using the keyboard controller option

keyboard_a20:
    cli
    mov al,0xdd                         # Enable the A20 line through the keyboard controller
    out 0x64,al
    sti

setup_stack:
    mov bp,0x8000                       # I'm not sure why i did this
    mov sp,bp
    jmp boot

    .include "function_defs.s"          # include necessary files
    .include "macro_defs.s"


boot:
                                        # call macros
    lea si,LOADING_OS
    call PrintString
    ReadDisk                            # load sectors into memory
    SetupGDT
    SetupIDT
    LoadDescriptorTables
    SwitchToPm
    PerformFarJump
    SetupSegments
    jmp 0x9000                          # jump to loaded sectors


LOADING_OS: .asciz "Loading OS Please Wait...\r\n"
.lcomm BOOT_DRIVE,4                     # reserve 4bytes for BOOT_DRIVE number                   

.fill (510-(.-_start)),1,0      # pad with zeroes
boot_magic: .int 0xAA55         # boot magik

.code32
init_pm:
    .include "second_stage.s"           # implement the second stage boot loader
    cli
    hlt
