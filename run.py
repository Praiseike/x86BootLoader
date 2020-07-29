#!/usr/bin/python
from os import system as execute
import sys,os
import subprocess

emulator = None


def check_bochs():
    ret = subprocess.call(['which','bochs'])
    if(ret == 0):
        print("[check: bochs installed? OK]")
    else:
        print ("Sorry you don't have bochs installed")
        print ("you can install bochs using: apt-get install bochs")
        quit()

def check_qemu():
    ret = subprocess.call(['which','qemu-system-x86_64'])
    if(ret != 0):
        print("Qemu not installed")
        print("Install qemu using: apt-get install qemu")
        exit()

       

def write_config(filename):
    with open(".bochsrc","w") as file:
        data = 'floppya: 1_44="kernel.img", status=inserted\nboot:a'#%filename
        file.write(data)


def run(args):
    filename = args[1]
    name = filename.split('.')[0]
    exec_ext0 = "make"
    exec_ext3 = "qemu-system-x86_64 kernel.img"#%name
    

    execute(exec_ext0)
    if(emulator == "bochs"):
        check_bochs()
        write_config(name)
        execute("bochs")
    else:
        check_qemu()
        execute(exec_ext3)


args = sys.argv

if (len(args) < 2):
    print("Usage: ./run filename")
else:
    if(len(args) >= 3):
        if("--bochs" in args):
            emulator = "bochs"
        else:
            emuator = "qemu"
    else:
        pass
    run(args)

   

