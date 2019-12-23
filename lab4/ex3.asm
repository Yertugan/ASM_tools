bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit  , printf, scanf             
import exit msvcrt.dll 
import printf msvcrt.dll 
import scanf msvcrt.dll   

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    msg db "Give me a number", 0
    format_1 db "%d", 0
    num_1 dd 0

; our code starts here
segment code use32 class=code
    start:
        push dword msg
        call [printf]
        add esp 4*1
        
        ;scanf(format_1, &num_1)
        push dword num_1
        call [scanf]
        add esp 4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
