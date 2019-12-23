bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    ;32) Given the words A, B si C, obtain the byte D as the sum of the integers represented by:
    ;the bits 0-4 of A
    ;the bits 5-9 of B
    ;The byte E is the integer represented by the bits 10-14 of C. Obtain the byte F by computing the subtraction D-E.
    a dw 0111011101010111b
    b dw 0001101110111110b
    c dw 0110110101101110b
    d db 0
    e db 0
    f db 0
; our code starts here
segment code use32 class=code
    start:
        
        mov ax, [a]
        and ax, 0000000000011111b ;isolating the 0-4bits of ax=a
        mov bx, [b]
        and bx, 0000001111100000b ;isolating the 5-9 bits of bx= b
        ror bx, 5 ;shift right to five bits
        add ax, bx
        mov [d], al
        
        mov bl, al 
        
        mov ax, [c]
        and ax, 0111110000000000b
        ror ax, 10
        mov [e], al
        
        sub bl, al
        
        mov [f], bl
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
