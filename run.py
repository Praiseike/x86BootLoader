#!/usr/bin/python

# Author: Praise Ike
# Email: Praiseike123@gmai.com


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

       

def write_config():
    with open(".bochsrc","w") as file:
        data = 'floppya: 1_44="kernel.img", status=inserted\nboot:a'
        file.write(data)


def run_build():
    exec_ext0 = "make"
    exec_ext3 = "qemu-system-x86_64 kernel.img"
    
    execute(exec_ext0)
    if(emulator == "bochs"):
        check_bochs()
        write_config()
        execute("bochs")
    else:
        check_qemu()
        execute(exec_ext3)
    execute("make clean");

args = sys.argv


if(len(args) > 1):
    if("--bochs" in args):
        emulator = "bochs"
    else:
        emuator = "qemu"
else:
    pass

run_build()
