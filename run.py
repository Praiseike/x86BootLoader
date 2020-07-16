#!/usr/bin/python
from os import system as execute
import sys

usebochs = None 

def write_config(filename):
    with open(".bochsrc","w") as file:
        data = 'floppya: 1_44="%s.bin", status=inserted\nboot:a'%filename
        file.write(data)


def run(args):
    filename = args[1]
    name = filename.split('.')[0]
    exec1 = "as -o %s.o %s"%(name,filename)
    exec2 = "ld -o %s.bin --oformat binary -Ttext 0x7c00 %s.o"%(name,name)
    exec3 = "qemu-system-x86_64 %s.bin"%name
    execute(exec1)
    execute(exec2)
    
    if(usebochs == True):
        write_config(name)
        execute("bochs")
    else:
        execute(exec3)


args = sys.argv

if (len(args) < 2):
    print("Usage: ./run filename")
else:
    if(len(args) >= 3):
        if("--bochs" in args):
            usebochs = True
        else:
            usebochs = False
    else:
        pass
    run(args)

   

