bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    msg db "Enter a number: ", 0
    format_1 db "%d", 0
    n dd 0
    base dd 10
    format_2 "The number of digits: %d", 0

; our code starts here
segment code use32 class=code
    count_digits:
        mov eax, [esp + 8]
        mov ebx, [esp + 4]
        mov ecx, 100
        .count:
            mov edx, 0
            div ebx
            
            cmp eax, 0
            je end_loop
        loop .count
        
        end_loop:
            mov eax, 100
            inc eax
            sub eax, ecx
               
        ret
    
    start:
        
          
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
