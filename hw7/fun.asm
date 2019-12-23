bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit , printf, scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf                         

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; Read two numbers a and b (in base 16) from the keyboard and calculate a+b. Display the result in base 10
    a dd 0
    b dd 0
    c dd 0
    
    message1  db "a=", 0 
    format1  db "%x", 0
    
    message2  db "b=", 0 
    format2  db "%x", 0
    format3 db "%d", 0

; our code starts here
segment code use32 class=code
    start:
        push dword message1
        call [printf]      ; call function printf for printing
        add esp, 4*1       ; free parameters on the stack; 4 = size of dword; 1 = number of parameters
        
        push dword a      ; ! addressa of n, not value
        push dword format1
        call [scanf]       ; call function scanf for reading
        add esp, 4 * 2     ; free parameters on the stack
                           ; 4 = size of a dword; 2 = no of perameters
                  
        push dword message2
        call [printf]      
        add esp, 4*1
        
        push dword b
        push dword format2
        call [scanf]
        add esp, 4*2
        
        mov eax, 0
        mov al, [a]
        add al, [b]
        
        mov [c], eax
        
        push dword [c] 
        push dword format3
        call [printf]
        
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
