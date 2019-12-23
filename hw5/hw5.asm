bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;A byte string S is given. Obtain the string D by concatenating the elements found on the even positions of S and then the elements ;found on the odd positions of S. 
    ;Example:
    ;S: 1, 2, 3, 4, 5, 6, 7, 8
    ;D: 1, 3, 5, 7, 2, 4, 6, 8
    s db '1','2','3','4','5','6','7','8'
    l equ $-s
    d times l db 0  

; our code starts here
segment code use32 class=code
    start:
        
        mov ecx, l/2
        mov esi, s ; offset source
        mov edi, d ; offset dest
        cld
        
        jecxz end_prog
        
        
        putodd:
            movsb ;lodsb and stosb
            ;mov al, [esi]
            ;inc esi
            ;mov [edi], al
            ;inc edi
            inc esi
        
        loop putodd
        mov ecx, l/2
        mov esi, s
        puteven:
            inc esi
            movsb
        
        loop puteven
        end_prog:    
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
