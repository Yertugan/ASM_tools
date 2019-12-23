bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;24)((a + b) + (a + c) + (b + c)) - d
    a db 3
    b dw 4
    c dd 2
    d dq 5

; our code starts here
segment code use32 class=code
    start:
       mov al, [a]
       mov ah, 0 ;unsigned conversion
       add ax, [b] ; add word [b] to [a], ax = a+b
       mov bx, ax ; save a+b
       mov al, [a]
       mov ah, 0
       mov dx, 0 ; unsigned conversion
       add ax, word [c]
       add dx, word [c+2]
       add bx, ax
       adc cx, dx
       mov ax, [b]
       mov dx, 0
       add ax, [c]
       add dx, [c+2]
       add bx, ax
       adc cx, dx
       push cx
       push bx
       pop ebx
       
       mov ecx, 0
       sub ebx, dword [d]
       sbb ecx, dword [d+4]
       
       
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
