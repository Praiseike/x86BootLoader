void kmain()
{
    char * video =(char *) 0xb8000;
    int i;
    for (i = 0;i < 4000;i+=2)
    {
        video[i] = '*';
        video[i+1] = 0x0a;
    }
    
}
