%include 'functions.asm'

section .data
  val1Msg db 'Enter val1 (0-65535): ', 0h ;Ask the user to enter a number
  val2Msg db 'Enter val2 (0-65535): ', 0h ;Ask the user to enter a number
  val3Msg db 'Enter val3 (0-65535): ', 0h ;Ask the user to enter a number
  nvalMsg db 'Enter nvalue (0-3): ', 0h ;Ask the user to enter a number
  inputMsg db 'Input out of bounds! ', 0h ;Ask the user to enter a number
  case0Msg db 'Case 0: ', 0h
  case1Msg db 'Case 1: ', 0h
  case2Msg db 'Case 2: ', 0h
  case3Msg db 'Case 3: ', 0h
  caseDefMsg db 'default', 0h

section .bss
  nvalue resb 5
  val1 resb 256
  val2 resb 256
  val3 resb 256

section .text
  global _start

_start:
  mov eax, val1Msg
  call sprint

  mov eax, 3
  mov ebx, 0
  mov ecx, val1
  mov edx, 256
  int 80h
  mov eax, val1
  call atoi
  call checkinput

  ; Prompt for val2
  mov eax, val2Msg
  call sprint

  mov eax, 3
  mov ebx, 0
  mov ecx, val2
  mov edx, 256
  int 80h
  mov eax, val2
  call atoi
  call checkinput

  ; Prompt for val 3
  mov eax, val3Msg
  call sprint

  mov eax, 3
  mov ebx, 0
  mov ecx, val3
  mov edx, 256
  int 80h
  mov eax, val3
  call atoi
  call checkinput

  ; Prompt for nvalue
  mov eax, nvalMsg
  call sprint

  mov eax, 3
  mov ebx, 0
  mov ecx, nvalue
  mov edx, 5
  int 80h
  mov eax, nvalue
  call atoi
  call checkinput

  ; Call switch logic
  call switch1

  call exit

switch1:
  mov eax, nvalue
  call atoi

  cmp eax, 0
  je case0

  cmp eax, 1
  je case1

  cmp eax, 2
  je case2

  cmp eax, 3
  je case3

  jne caseDefault

case0:
  mov eax, case0Msg
  call sprint
  mov eax, val1
  call atoi
  mov ebx, eax
  mov eax, val2
  call atoi
  mul ebx
  call iprintLF
  ret

case1:
  mov eax, case1Msg
  call sprint
  mov eax, val2
  call atoi
  mov ebx, eax
  mov eax, val3
  call atoi
  mul ebx
  call iprintLF
  ret

case2:
  mov eax, case2Msg
  call sprint
  mov eax, val1
  call atoi
  mov ebx, eax
  mov eax, val3
  call atoi
  sub eax, ebx
  call iprintLF
  ret

case3:
  mov eax, case3Msg
  call sprint
  mov eax, val3
  call atoi
  mov ebx, eax
  mov eax, val1
  call atoi
  sub eax, ebx
  call iprintLF
  ret

caseDefault:
  mov eax, caseDefMsg
  call sprint
  ret

checkinput:
  call iprintLF
  cmp eax, 0
  jl error_exit
  cmp eax, 65535
  jg error_exit
  ret

error_exit:
  mov eax, inputMsg
  call sprintLF
  call exit

exit:
  mov eax, 1
  mov ebx, 0
  int 80h
