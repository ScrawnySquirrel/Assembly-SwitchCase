section .data
  inputNum db 'Enter a number (1-3): ' ;Ask the user to enter a number
  inMsgLen equ $-inputNum  ;The length of the message
  case1Msg db 'first', 0xa
  c1MsgLen equ $-case1Msg
  case2Msg db 'second', 0xa
  c2MsgLen equ $-case2Msg
  case3Msg db 'third', 0xa
  c3MsgLen equ $-case3Msg
  caseDefMsg db 'default', 0xa
  cDefMsgLen equ $-caseDefMsg

section .bss
  num resb 5

section .text
  global _start

_start:
  mov eax, 4
  mov ebx, 1 ; descriptor value for stdout
  mov ecx, inputNum
  mov edx, inMsgLen
  int 80h

  ;Read and store the user input
  mov eax, 3
  mov ebx, 0 ; descriptor value for stdin
  mov ecx, num
  mov edx, 5 ;5 bytes (numeric, 1 for sign) of that information
  int 80h

  call switch1

  call exit

switch1:
  mov eax, num
  call atoi

  cmp eax, 1
  je case1

  cmp eax, 2
  je case2

  cmp eax, 3
  je case3

  jne caseDefault

atoi:
  push ebx  ; preserve ebx on the stack to be restored after function runs
  push ecx  ; preserve ecx on the stack to be restored after function runs
  push edx  ; preserve edx on the stack to be restored after function runs
  push esi  ; preserve esi on the stack to be restored after function runs
  mov esi, eax ; move pointer in eax into esi (our number to convert)
  mov eax, 0  ; initialise eax with decimal value 0
  mov ecx, 0  ; initialise ecx with decimal value 0

.multiplyLoop:
  xor ebx, ebx ; resets both lower and uppper bytes of ebx to be 0
  mov bl, [esi+ecx]   ; move a single byte into ebx register's lower half
  cmp bl, 48  ; compare ebx register's lower half value against ascii value 48 (char value 0)
  jl  .finished   ; jump if less than to label finished
  cmp bl, 57  ; compare ebx register's lower half value against ascii value 57 (char value 9)
  jg  .finished   ; jump if greater than to label finished

  sub bl, 48  ; convert ebx register's lower half to decimal representation of ascii value
  add eax, ebx ; add ebx to our interger value in eax
  mov ebx, 10  ; move decimal value 10 into ebx
  mul ebx  ; multiply eax by ebx to get place value
  inc ecx  ; increment ecx (our counter register)
  jmp .multiplyLoop   ; continue multiply loop

.finished:
  cmp ecx, 0  ; compare ecx register's value against decimal 0 (our counter register)
  je  .restore ; jump if equal to 0 (no integer arguments were passed to atoi)
  mov ebx, 10  ; move decimal value 10 into ebx
  div ebx  ; divide eax by value in ebx (in this case 10)

.restore:
  pop esi  ; restore esi from the value we pushed onto the stack at the start
  pop edx  ; restore edx from the value we pushed onto the stack at the start
  pop ecx  ; restore ecx from the value we pushed onto the stack at the start
  pop ebx  ; restore ebx from the value we pushed onto the stack at the start
  ret

print:
  mov eax, 4
  mov ebx, 1
  int 80h
  ret

case1:
  mov ecx, case1Msg
  mov edx, c1MsgLen
  call print
  ret

case2:
  mov ecx, case2Msg
  mov edx, c2MsgLen
  call print
  ret

case3:
  mov ecx, case3Msg
  mov edx, c3MsgLen
  call print
  ret

caseDefault:
  mov ecx, caseDefMsg
  mov edx, cDefMsgLen
  call print
  ret

exit:
  mov eax, 1
  mov ebx, 0
  int 80h
