section .data
  inputNum db 'Enter a number (0-9): ' ;Ask the user to enter a number
  inMsgLen equ $-inputNum          ;The length of the message

section .bss
  num resb 5

section .text
  global _start

_start:
  mov eax, 4
  mov ebx, 1     ; descriptor value for stdout
  mov ecx, inputNum
  mov edx, inMsgLen
  int 80h

  ;Read and store the user input
  mov eax, 3
  mov ebx, 0     ; descriptor value for stdin
  mov ecx, num
  mov edx, 5     ;5 bytes (numeric, 1 for sign) of that information
  int 80h

  mov eax,0
  cmp eax,num
  je case0

  mov eax,1
  cmp eax,num
  je case1

  mov eax,2
  cmp eax,num
  je case2

  mov eax,3
  cmp eax,num
  je case3

  mov eax,4
  cmp eax,num
  je case4

  mov eax,5
  cmp eax,num
  je case5

  mov eax,6
  cmp eax,num
  je case6

  mov eax,7
  cmp eax,num
  je case7

  mov eax,8
  cmp eax,num
  je case8

  mov eax,9
  cmp eax,num
  je case9

  jmp caseDefault

  call exit

print:
  mov eax, 4
  mov ebx, 1     ; descriptor value for stdout
  mov ecx, num
  mov edx, 2
  int 80h
  ret

case0:
  call print
case1:
  call print
case2:
  call print
case3:
  call print
case4:
  call print
case5:
  call print
case6:
  call print
case7:
  call print
case8:
  call print
case9:
  call print
caseDefault:
  call print

exit:
  mov eax, 1
  mov ebx, 0
  int 80h
