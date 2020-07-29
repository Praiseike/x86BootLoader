00000000  8816              mov [esi],dl
00000002  C0CEB8            ror dh,byte 0xb8
00000005  0124CD15BD0080    add [ecx*8-0x7fff42eb],esp
0000000C  89EC              mov esp,ebp
0000000E  E98900ACB4        jmp dword 0xb4ac009c
00000013  0E                push cs
00000014  BB090008C0        mov ebx,0xc0080009
00000019  7404              jz 0x1f
0000001B  CD10              int 0x10
0000001D  EBF2              jmp short 0x11
0000001F  C3                ret
00000020  52                push edx
00000021  B402              mov ah,0x2
00000023  B500              mov ch,0x0
00000025  88F0              mov al,dh
00000027  B600              mov dh,0x0
00000029  B102              mov cl,0x2
0000002B  8A16              mov dl,[esi]
0000002D  C0CECD            ror dh,byte 0xcd
00000030  13720D            adc esi,[edx+0xd]
00000033  5A                pop edx
00000034  38C6              cmp dh,al
00000036  7508              jnz 0x40
00000038  8D36              lea esi,[esi]
0000003A  49                dec ecx
0000003B  7CE8              jl 0x25
0000003D  D2FF              sar bh,cl
0000003F  C3                ret
00000040  8D36              lea esi,[esi]
00000042  737C              jnc 0xc0
00000044  E8CAFFEBFE        call dword 0xfeec0013
00000049  46                inc esi
0000004A  696E6973686564    imul ebp,[esi+0x69],dword 0x64656873
00000051  204C6F61          and [edi+ebp*2+0x61],cl
00000055  64696E6720736563  imul ebp,[fs:esi+0x67],dword 0x63657320
0000005D  746F              jz 0xce
0000005F  7273              jc 0xd4
00000061  207375            and [ebx+0x75],dh
00000064  636365            arpl [ebx+0x65],sp
00000067  7373              jnc 0xdc
00000069  66756C            o16 jnz 0xd8
0000006C  6C                insb
0000006D  793A              jns 0xa9
0000006F  200A              and [edx],cl
00000071  0D00446973        or eax,0x73694400
00000076  6B2045            imul esp,[eax],byte +0x45
00000079  7272              jc 0xed
0000007B  6F                outsd
0000007C  723A              jc 0xb8
0000007E  20556E            and [ebp+0x6e],dl
00000081  61                popad
00000082  626C6520          bound ebp,[ebp+0x20]
00000086  746F              jz 0xf7
00000088  207265            and [edx+0x65],dh
0000008B  61                popad
0000008C  64206672          and [fs:esi+0x72],ah
00000090  6F                outsd
00000091  6D                insd
00000092  20646973          and [ecx+ebp*2+0x73],ah
00000096  6B0A0D            imul ecx,[edx],byte +0xd
00000099  008D36537DE8      add [ebp-0x1782acca],cl
0000009F  70FF              jo 0xa0
000000A1  8D36              lea esi,[esi]
000000A3  6E                outsb
000000A4  7DE8              jnl 0x8e
000000A6  69FFBB0090B6      imul edi,edi,dword 0xb69000bb
000000AC  02E8              add ch,al
000000AE  70FF              jo 0xaf
000000B0  B800008EC0        mov eax,0xc08e0000
000000B5  BF0008B904        mov edi,0x4b90800
000000BA  00F3              add bl,dh
000000BC  AB                stosd
000000BD  26C705FFFF26C745  mov dword [dword es:0xc726ffff],0x245
         -020000
000000C8  26C6450400        mov byte [es:ebp+0x4],0x0
000000CD  26C645059A        mov byte [es:ebp+0x5],0x9a
000000D2  26C64506CF        mov byte [es:ebp+0x6],0xcf
000000D7  26C6450700        mov byte [es:ebp+0x7],0x0
000000DC  83C708            add edi,byte +0x8
000000DF  26C705FFFF26C745  mov dword [dword es:0xc726ffff],0x245
         -020000
000000EA  26C6450400        mov byte [es:ebp+0x4],0x0
000000EF  26C6450592        mov byte [es:ebp+0x5],0x92
000000F4  26C64506CF        mov byte [es:ebp+0x6],0xcf
000000F9  26C6450700        mov byte [es:ebp+0x7],0x0
000000FE  1800              sbb [eax],al
00000100  0008              add [eax],cl
00000102  0000              add [eax],al
00000104  B800008EC0        mov eax,0xc08e0000
00000109  BF0000B900        mov edi,0xb90000
0000010E  08F3              or bl,dh
00000110  AA                stosb
00000111  0008              add [eax],cl
00000113  0000              add [eax],al
00000115  0000              add [eax],al
00000117  0F0116            lgdt [esi]
0000011A  FE                db 0xfe
0000011B  7C0F              jl 0x12c
0000011D  011E              add [esi],ebx
0000011F  117DFA            adc [ebp-0x6],edi
00000122  0F20C0            mov eax,cr0
00000125  6683C801          or ax,byte +0x1
00000129  0F22C0            mov cr0,eax
0000012C  EA347D08009090    jmp dword 0x9090:0x87d34
00000133  90                nop
00000134  B8BC0A0000        mov eax,0xabc
00000139  66B81000          mov ax,0x10
0000013D  8EC0              mov es,eax
0000013F  8ED8              mov ds,eax
00000141  8EC0              mov es,eax
00000143  8EE8              mov gs,eax
00000145  8EE0              mov fs,eax
00000147  8ED0              mov ss,eax
00000149  BC00000900        mov esp,0x90000
0000014E  E9AD120000        jmp dword 0x1400
00000153  57                push edi
00000154  656C              gs insb
00000156  636F6D            arpl [edi+0x6d],bp
00000159  6520746F20        and [gs:edi+ebp*2+0x20],dh
0000015E  6D                insd
0000015F  7920              jns 0x181
00000161  626F6F            bound ebp,[edi+0x6f]
00000164  744C              jz 0x1b2
00000166  6F                outsd
00000167  61                popad
00000168  6465720D          gs jc 0x179
0000016C  0A00              or al,[eax]
0000016E  4C                dec esp
0000016F  6F                outsd
00000170  61                popad
00000171  64696E67204F5320  imul ebp,[fs:esi+0x67],dword 0x20534f20
00000179  50                push eax
0000017A  6C                insb
0000017B  6561              gs popad
0000017D  7365              jnc 0x1e4
0000017F  207761            and [edi+0x61],dh
00000182  69742E2E2E0A0D00  imul esi,[esi+ebp+0x2e],dword 0xd0a2e
0000018A  0000              add [eax],al
0000018C  0000              add [eax],al
0000018E  0000              add [eax],al
00000190  0000              add [eax],al
00000192  0000              add [eax],al
00000194  0000              add [eax],al
00000196  0000              add [eax],al
00000198  0000              add [eax],al
0000019A  0000              add [eax],al
0000019C  0000              add [eax],al
0000019E  0000              add [eax],al
000001A0  0000              add [eax],al
000001A2  0000              add [eax],al
000001A4  0000              add [eax],al
000001A6  0000              add [eax],al
000001A8  0000              add [eax],al
000001AA  0000              add [eax],al
000001AC  0000              add [eax],al
000001AE  0000              add [eax],al
000001B0  0000              add [eax],al
000001B2  0000              add [eax],al
000001B4  0000              add [eax],al
000001B6  0000              add [eax],al
000001B8  0000              add [eax],al
000001BA  0000              add [eax],al
000001BC  0000              add [eax],al
000001BE  0000              add [eax],al
000001C0  0000              add [eax],al
000001C2  0000              add [eax],al
000001C4  0000              add [eax],al
000001C6  0000              add [eax],al
000001C8  0000              add [eax],al
000001CA  0000              add [eax],al
000001CC  0000              add [eax],al
000001CE  0000              add [eax],al
000001D0  0000              add [eax],al
000001D2  0000              add [eax],al
000001D4  0000              add [eax],al
000001D6  0000              add [eax],al
000001D8  0000              add [eax],al
000001DA  0000              add [eax],al
000001DC  0000              add [eax],al
000001DE  0000              add [eax],al
000001E0  0000              add [eax],al
000001E2  0000              add [eax],al
000001E4  0000              add [eax],al
000001E6  0000              add [eax],al
000001E8  0000              add [eax],al
000001EA  0000              add [eax],al
000001EC  0000              add [eax],al
000001EE  0000              add [eax],al
000001F0  0000              add [eax],al
000001F2  0000              add [eax],al
000001F4  0000              add [eax],al
000001F6  0000              add [eax],al
000001F8  0000              add [eax],al
000001FA  0000              add [eax],al
000001FC  0000              add [eax],al
000001FE  55                push ebp
000001FF  AA                stosb
00000200  0000              add [eax],al
00000202  8B352B7E0000      mov esi,[dword 0x7e2b]
00000208  E807000000        call dword 0x214
0000020D  E835000000        call dword 0x247
00000212  FA                cli
00000213  F4                hlt
00000214  60                pushad
00000215  BA00800B00        mov edx,0xb8000
0000021A  AC                lodsb
0000021B  3C00              cmp al,0x0
0000021D  740A              jz 0x229
0000021F  B40F              mov ah,0xf
00000221  668902            mov [edx],ax
00000224  83C202            add edx,byte +0x2
00000227  EBF1              jmp short 0x21a
00000229  61                popad
0000022A  C3                ret
0000022B  57                push edi
0000022C  656C              gs insb
0000022E  636F6D            arpl [edi+0x6d],bp
00000231  6520746F20        and [gs:edi+ebp*2+0x20],dh
00000236  7072              jo 0x2aa
00000238  6F                outsd
00000239  7465              jz 0x2a0
0000023B  63746564          arpl [ebp+0x64],si
0000023F  206D6F            and [ebp+0x6f],ch
00000242  64650A0D005589E5  or cl,[dword gs:0xe5895500]
0000024A  83EC10            sub esp,byte +0x10
0000024D  C745F800800B00    mov dword [ebp-0x8],0xb8000
00000254  C745FC00000000    mov dword [ebp-0x4],0x0
0000025B  EB1D              jmp short 0x27a
0000025D  8B55FC            mov edx,[ebp-0x4]
00000260  8B45F8            mov eax,[ebp-0x8]
00000263  01D0              add eax,edx
00000265  C6002A            mov byte [eax],0x2a
00000268  8B45FC            mov eax,[ebp-0x4]
0000026B  8D5001            lea edx,[eax+0x1]
0000026E  8B45F8            mov eax,[ebp-0x8]
00000271  01D0              add eax,edx
00000273  C6000A            mov byte [eax],0xa
00000276  8345FC02          add dword [ebp-0x4],byte +0x2
0000027A  817DFC9F0F0000    cmp dword [ebp-0x4],0xf9f
00000281  7EDA              jng 0x25d
00000283  C9                leave
00000284  C3                ret
00000285  0000              add [eax],al
00000287  001400            add [eax+eax],dl
0000028A  0000              add [eax],al
0000028C  0000              add [eax],al
0000028E  0000              add [eax],al
00000290  017A52            add [edx+0x52],edi
00000293  0001              add [ecx],al
00000295  7C08              jl 0x29f
00000297  011B              add [ebx],ebx
00000299  0C04              or al,0x4
0000029B  0488              add al,0x88
0000029D  0100              add [eax],eax
0000029F  001C00            add [eax+eax],bl
000002A2  0000              add [eax],al
000002A4  1C00              sbb al,0x0
000002A6  0000              add [eax],al
000002A8  9F                lahf
000002A9  FF                db 0xff
000002AA  FF                db 0xff
000002AB  FF                db 0xff
000002AC  3E0000            add [ds:eax],al
000002AF  0000              add [eax],al
000002B1  41                inc ecx
000002B2  0E                push cs
000002B3  088502420D05      or [ebp+0x50d4202],al
000002B9  7AC5              jpe 0x280
000002BB  0C04              or al,0x4
000002BD  0400              add al,0x0
000002BF  00                db 0x00
