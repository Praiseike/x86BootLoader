// Author: Praise Ike
// Email: Praiseike123@gmail.com

#include "../drivers/screen.h"
#define GREEN_ON_BLACK 0xa0

void drawBox(unsigned char row,unsigned char col,unsigned char width,unsigned char height,char color)
{

    int i;
    for(i = 0;i< width;i++)
    {
        print_char(' ',row,col+i,color);
    }

    for(i = 0;i<height;i++)
    {
        print_char(' ',row+i,col,color);
        print_char(' ',row+i,col+width,color);
    }
    
    for(i = 0;i< width+1;i++)
    {
        print_char(' ',height+1,col+i,color);
    }
 
}


void kmain()
{
    char message[] = "WELCOME TO PROTECTED MODE";
    clear_screen();
    drawBox(1,1,20,10,GREEN_ON_BLACK);
    drawBox(1,27,20,10,GREEN_ON_BLACK);
    drawBox(1,53,20,10,GREEN_ON_BLACK);    
    print(message,20,20);
}


