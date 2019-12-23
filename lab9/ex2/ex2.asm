bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, scanf              
import exit msvcrt.dll    
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll

%include "findmin.asm"
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;Read a string of unsigned numbers in base 10 from keyboard. Determine the minimum value of the string and write it in the file min.txt (it will be created) in 16 base.
     file_name db "min.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
   
    n dd 0 
    min dd 255
	format db "%d", 0
    format2 db "%x", 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, 100
        
        push dword n
        push dword format
        call [scanf]       ; call function scanf for reading
        add esp, 4 * 2 
        mov ebx, [n]
        
        repeta:
            push dword n       ; ! addressa of n, not value
            push dword format
            call [scanf]       ; call function scanf for reading
            add esp, 4 * 2
            
            mov edx, [n]
            cmp edx, 255
            je final1   
            
            push edx
            call findmin  
            
            loop repeta
            
        final1:
        
        pop eax
        mov [n], eax
        
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack

        mov [file_descriptor], eax  ; store the file descriptor returned by fopen
        
        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final
        
        push dword [n]
         
        push dword format2
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*3
        
        
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        
        
        final:
        
        ; exit(0)
        push dword 0      ; push the parameter for exit onto the stack
        call [exit]       ; call exit to terminate the program
