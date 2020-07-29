#include "../kernel/low_level.c"
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
    int offset = (row * 2 * 80) + col;
    return offset;
}
int get_cursor()
{
    // reg 14: high byte of cursor offset
    // reg 15: low byte of cursor offset
    port_byte_out(REG_SCREEN_CTRL,14);
    int offset = port_byte_in(REG_SCREEN_DATA) << 8;
    port_byte_out(REG_SCREEN_CTRL,15);
    offset += port_byte_in(REG_SCREEN_DATA);
    return offset*2;    // no chars * 2 = cell offset
}

void set_cursor(int offset) 
{
    offset /= 2;    // convert from cell to char offset
    // write bytes to internal device registers
    port_byte_out(REG_SCREEN_CTRL,14);
    prot_byte_out(REG_SCREEN_DATA,(unsigned char)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL,15);
    //port_byte_out(REG_SCREEN_DATA,(unsigned char)(offsect << 8));
    
    cursor_offset -= 2*MAX_COLS;
    return cursor_offset;


void print_char(char ch,int row,int col,char attrib)
{

    unsigned char * video = (unsigned char *)VIDEO_MEMORY;

    if(!attrib)
        attrib=WHITE_ON_BLACK;



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
    offset = handle_scrolling(offset);
    set_cursor(offset);
}

void print_at(char * message,int row,int col)
{
    if(col >= 0 && row >= 0)
    {
        set_cursor(get_screen_offset(row,col));

    }

    int i = 0;
    while(message[i] != 0)
    {
        print_char(message[i++],row,col,WHITE_ON_BLACK);
    }
}

void print(char * message)
{
    print_at(message,-1,-1);
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
