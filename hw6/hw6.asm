bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
;30) A string of words is given. Build two strings of bytes, s1 and s2, in the following way: for each word,
;if the number of bits 1 from the high byte of the word is larger than the number of bits 1 from its low byte, then s1 will contain the high byte and s2 will contain the low byte of the word
;if the number of bits 1 from the high byte of the word is equal to the number of bits 1 from its low byte, then s1 will contain the number of bits 1 from the low byte and s2 will contain 0
;otherwise, s1 will contain the low byte and s2 will contain the high byte of the word.

segment data use32 class=data
    s dw 0402h, 0304h, 0105h
    l equ $-s
    s1 times l db 0
    s2 times l db 0

; our code starts here
segment code use32 class=code
    start:
        mov esi, s 
        cld 
        mov ecx, l 
        
        
        jecxz end_prog
        
        putbyte:
            lodsw
            cmp al, ah
            jg putlarge
            je putequal
            jl putless
        
        putlarge:
            mov [s1], ah
            mov [s2], al 
            
        putequal:
            mov bl, 0
            mov [s2], bl
            mov cl, 100
            cmp al, 1
            jc cntone
        
        putless:
            mov [s1], al
            mov [s1], ah
        
        cntone: ;count how many 1s in low byte
            mov dl, 100
            inc cl
            sub dl, cl
            mov [s1], dl
        
        loop putbyte
        
        end_prog:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
