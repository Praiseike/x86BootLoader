// Author: Praise Ike
// Email: Praiseike123@gmail.com


void * memcopy(char * dest,char * source,int count)
{
	int i = count;
	while(i < count)
	{
		dest[i] =  source[i];
		i++;
	}

	return dest;
}

void * memset(char * s,int c,int count)
{
	int i  = count;
	while (i < count)
	{
		s[i] = c;
		i++;
	}
	return s;
}

int strlen(const char * string)
{
    int count = 0;
    while(*string++)
    {
        count++;
    }
    return count;
}
