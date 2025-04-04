section .data
    ; get pathname
    pathname dd 'randomInt100.txt'

    ; get size of buffer
    bufferSize dd 1024

section .bss 
    ; reserve a buffer with 1024 bytes
    buffer: resb 1024



section .text

    global _start

_start:

    ; open read to file
    mov eax, 5
    ; take in pathname
    mov ebx, pathname
    ; store int
    mov ecx, 0
    int 0x80
    jmp read

read:

    ; move descriptor into eax
    mov ebx, eax
    ; read in the file
    mov eax, 3
    ; move the data from the read to the buffer
    mov ecx, buffer
    ; move the length of the buffer into edx
    mov edx, bufferSize
    int 0x80

    

additionLoop:
    ; compare the current iter to counter
    cmp ecx, buffer
    ; if equal, print
    je print
    ; if not, add 1 to counter, go to getNumLoop

    add ecx, 1
    jmp getNumberLoop

getNumberLoop:
    ; compare current buffer to see if next char is newline
    cmp byte [buffer + edi], 0xA
    ; if so, add buffer to ecx and go back to addition loop
    add edx, [buffer + edi]
    je additionLoop

    add edi, 1
    jmp getNumberLoop

print:
    
    ; put sum in ecx
    mov ecx, edx
    ; print the resulting int
    mov edx, eax
    mov eax, 4
    mov ebx, 1
    int 0x80

    ; exit
    mov eax, 1
    mov ebx, 0
    int 0x80

