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
    offset |= port_byte_in(REG_SCREEN_DATA);
    port_byte_out(REG_SCREEN_CTRL,0x0e);
    offset |= (port_byte_in(REG_SCREEN_DATA) << 8);
    return offset*2;    // no chars * 2 = cell offset
}

void set_cursor(int offset) 
{
    offset /= 2;    // convert from cell to char offset
    // write bytes to internal device registers
    port_byte_out(REG_SCREEN_CTRL,15);
    port_byte_out(REG_SCREEN_DATA,(unsigned char)(offset & 0xff));
    port_byte_out(REG_SCREEN_CTRL,14);
    port_byte_out(REG_SCREEN_DATA,(unsigned char)((offset >> 8) & 0xff));
    
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

    offset += 2;
    set_cursor(offset);
}

void print_at(char * message,int row,int col)
{

    char * video = (char *)VIDEO_MEMORY;
    if(col >= 0 && row >= 0)
    {
        set_cursor(get_screen_offset(row,col));
    }
    int i = 0;
    int len = 7;//strlen(message);
    int offset = get_screen_offset(row,col);
    while(i < len);
    {
        video[offset+i] = '*';
        video[offset+i+1] = 0xa7;
        i++;
    }
}

void print(char * message)
{
    char * video = (char *)VIDEO_MEMORY;
    int j = 0,i= 0;
    while(*message != 0)
    {
        *video++ = *message++;
        *video++ = 0x07;
    }
}

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
    set_cursor(get_screen_offset(0,0));
}
