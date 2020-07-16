.code16
.global init
.intel_syntax noprefix
init:
    jmp init
    ljmp 0xffff:0xffff

.fill 510-(.-init),1,0
.word 0xaa55
