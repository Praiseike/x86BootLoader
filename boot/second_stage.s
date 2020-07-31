# Author: Praise Ike
# Email: Praiseike123@gmail.com



.code32
.extern kmain

begin_kernel:
    mov esi,WELCOME_MSG
    call print_string32
    call kmain
    cli
    hlt

.include "print32.s"

WELCOME_MSG: .asciz "Welcome to protected mode\n\r"
