# Assembly-SwitchCase
nasm -f elf -g switch.asm
ld -m elf_i386 -o switch switch.o
./switch
