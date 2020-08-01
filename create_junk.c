#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc,char ** argv)

{
    if(argc < 2)
    {
        printf("Usage: create_junk size\n");
        exit(0);
    }
    
    int size = atoi(argv[1]);
    FILE * file; 
    file = fopen("junk.bin","wb");
    char data = 0x0; 
    fwrite(&data,1,size,file);
    fclose(file);
    return 0;
}
