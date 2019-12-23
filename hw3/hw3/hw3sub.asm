bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 24)(a + b + c) - d + (b - c)
    a db 3
    b dw 5
    c dd 4
    d dq 2

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        cbw ; signed conversion al to ah
        add ax, [b] ;ax = a+b
        cwd ; signed conversion ax to dx:ax
        mov bx, word [c]	
        mov cx, word [c+2] ;cx:bx=a
        add ax, bx 
        adc dx, cx ; dx:ax = a+b+c
        push dx
        push ax
        pop eax
        cdq
        mov edx, 0
        sub eax, dword [d]
        sbb edx, dword [d+4]
        mov ebx, eax
        mov ecx, edx
        
        mov ax, [b]
        cwd
        sub ax, word [c]
        sbb dx, word [c+2]
        cdq
        add ebx, eax
        adc ecx, edx
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
