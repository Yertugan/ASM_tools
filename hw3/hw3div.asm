bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;24) a-(7+x)/(b*b-c/d+2); a-doubleword; b,c,d-byte; x-qword
    ;signed
    a dd 15
    b db 3
    c db 4
    d db 2
    x dq 11

; our code starts here
segment code use32 class=code
    start:
        mov al, [b]
        mov ah, [b]
        imul ah
        mov bx, ax
        mov al, [c]
        idiv byte [d]
        cbw
        sbb bx, ax
        adc bx, 2
        mov ax, bx
        cwd
        cdq
        mov ebx, eax
        mov ecx, edx
        
        mov ax, 7
        cwd
        cdq
        add eax, dword [x]
        adc edx, dword [x+4]
        idiv dword ebx
        mov ebx, eax
        mov ecx, edx
        
        mov eax, [a]
        cdq
        sbb eax, ebx
        sbb edx, ecx
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
