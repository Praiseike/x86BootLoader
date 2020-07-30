#include "../drivers/screen.h"

void kmain()
{
    char message[] = "Welcome to protected mode";
    clear_screen();
    print(message);  
    
}

