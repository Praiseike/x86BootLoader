#include "../kernel/low_level.c"
#include "../kernel/mem.c"

#define VIDEO_MEMORY 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

// device char attributes
#define WHITE_ON_BLACK 0x0f

// I/O PORTS
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

//
//  For calculating cell postion in memory
int get_screen_offset(int row,int col)
{
    int offset = (row * 80 + col)*2;
    return offset;
}

int get_cursor(void)
{
    // reg 14: high byte of cursor offset
    // reg 15: low byte of cursor offset
    unsigned short offset = 0;
    port_byte_out(REG_SCREEN_CTRL,0x0f);
    offset |= port_byte_in(REG_SCREEN_DATA);    // write higher 4 bits to I/O port
    port_byte_out(REG_SCREEN_CTRL,0x0e);
    offset |= (port_byte_in(REG_SCREEN_DATA) << 8); // write lower 4 bits to I/O port
    return offset*2;    // no chars * 2 = cell offset
}

void set_cursor(int offset) 
{
    offset /= 2;    // convert from cell to char offset
    // write bytes to internal device registers
    port_byte_out(REG_SCREEN_CTRL,15);      
    port_byte_out(REG_SCREEN_DATA,(unsigned char)(offset & 0xff));  // read higher 4 bits
    port_byte_out(REG_SCREEN_CTRL,14);
    port_byte_out(REG_SCREEN_DATA,(unsigned char)((offset >> 8) & 0xff));   // read lower 4 bits
    
}
		
void print_char(char ch,int row,int col,unsigned char attrib)
{

    unsigned char * video = (unsigned char *)VIDEO_MEMORY;      

    int offset;
    // if row and col are not -ve
    if(col >=0 && row>=0)
    {
        offset = get_screen_offset(row,col);
    }
    else
    {
        offset = get_cursor();
    }
    
    // check for new line
    if(ch == '\n')
    {
        int rows = offset/(2*MAX_COLS);
        offset = get_screen_offset(col,MAX_ROWS -1);
    }
    else
    {
        video[offset] = ch;
        video[offset+1] = attrib;
    }
    
    //set next position
    offset += 2;
    set_cursor(offset);
}


void print(char * message,int x,int y)
{
    int offset = get_screen_offset(x,y);    // Get current cell position in memory
    char * video = (char *)VIDEO_MEMORY + offset;   // add the cell offset to the start of the vga memory
    int i= 0;

    while(*message != 0)
    {
        *video++ = *message++;
        *video++ = 0x07;
        i++;
    }

    
    set_cursor(offset+(2*i));       // place the cursor at the end of the written text
    
}

// Cleas the screen by using the print_char abstraction

void clear_screen()
{
    int row = 0;
    int col = 0;

    for(row = 0;row<MAX_ROWS;row++)
    {
        for(col=0;col<MAX_COLS;col++)
        {
            print_char(' ',row,col,WHITE_ON_BLACK);
        }
    }

    set_cursor(get_screen_offset(0,0));
}


//  Clears the screen by directly set all chars to ' ' from 0xb8000 to 0xb8fa0
void force_clear_screen()
{
    char * video = (char *)VIDEO_MEMORY;
    int length = 2*80*25;
    int i = 0;
    while (i < length)
    {
        video[i] = ' ';
        video[i+1] = 0x07;
        i+=2;
    }
    set_cursor(get_screen_offset(0,0)); // Reset the cursor to the first row and column
}
