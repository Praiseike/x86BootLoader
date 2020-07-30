#include "../drivers/screen.h"

void kmain()
{
    char * message = "Welcome to protected mode";
    clear_screen();
    print_char(*(message+2),1,1,0x07);
}
