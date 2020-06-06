# AMPT_Labwork
This repository contains all the assignments related to Advanced microprocessors x86 and mmx controllers.

## What's inside? 

1.  a) First assignment is related to printing the keypresses on qemu screen by writing in video memory using interrupt  
    b) Second part is related to printing without using interrupt.  
2. Second assignment is jumping from real mode to protected mode and from there coming back.  
3. Third assignment is printing transpose of matrix using mmx registers

## How to Run

1.  First one must have qemu installed on machine with nasm. Set up the working environment.

2.  To run part 1.a use following commands in shell:
    > nasm -fbin printchar.asm -o printchar.bin    
    > qemu-system-i386 printchar.bin  
    
3.  To run part 1.b use following commands in shell:
    > nasm -fbin bootloader.asm -o bootloader.bin  
    > nasm -fbin realmode.asm -o realmode.bin  
    > cat bootloader.bin realmode.bin > result.bin  
    > qemu-system-i386 result.bin  
    
4.  To run part part 2 use following commands in shell: 
    > nasm -fbin modejump.asm -o modejump.bin  
    > qemu-system-i386 modejump.bin  
 
5.  To run part 3 use following commands in shell:
    > nasm -fbin bootloader.asm -o bootloader.bin  
    > nasm -fbin transpose_of_matrix.asm -o transpose.bin  
    > cat bootloader.bin transpose.bin > result.bin  
    > qemu-system-i386 result.bin  
