unsigned char port_byte_in(unsigned short port)
{
    unsigned char result;
    // Reading data from I/O port
    // edx = port
    // eax = result
    //
    __asm__("in %%dx,%%al;" : "=a" (result) : "d" (port));
    return result;
}

void port_byte_out(unsigned short port,unsigned char data)
{
    // Writing data to I/O port
    // eax = data
    // edx = port
    __asm__("out %%al,%%dx;" : : "a" (data) , "d" (port));
}

unsigned short port_word_in(unsigned short port)
{
    unsigned short result;
    __asm__("in %%dx,%%ax" : "=a" (result) : "d" (port)); 
    return result;
}

void port_word_out(unsigned short port,unsigned short data)
{
    __asm__("out %%ax,%%dx" : :"a" (data) ,"d" (port));
}

