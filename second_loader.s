.code32

VGA_MEM = 0xb8000

print_string32:
    
cli
hlt



WELCOME_MSG: .asciz "Welcome to protected mode\n\r"
