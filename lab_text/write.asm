bits 32

global start        

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    len dd 0                          ; the actual length of sentence
    max equ 100                       ; the maximum length of sentence
    stop dd '.'                       ; the stop char
    letter dd 0                       ; the current letter
    
    sentence times max+1 db 0         ; buffer to hold the sentence
    
    msg_r db "Enter a sentence: ", 0
    format_r db '%c', 0
    
    msg_p db "The sentence: ", 0
    format_p db '%s', 0

; This program reads a sentence from the keyboard and displays it.
; The sentence ends with a stop char '.'. The sentence is read letter by letter.
segment code use32 class=code
start:
    ; display a message to user
    push dword msg_r
    call [printf]
    add esp, 4*1
    
    cld
    mov ecx, max
    mov edi, sentence
    read_sent:                  ; loop to read the sentence char by char
        push ecx
    
        push dword letter
        push dword format_r
        call [scanf]
        add esp, 4*2
        
        xor eax, eax
        mov eax, [letter]
        
        cmp eax, [stop]         ; stop if '.'
        je stop_read
        
        stosb                   ; store the current letter
        
        pop ecx
    loop read_sent
    
    stop_read:
        mov eax, max
        sub eax, ecx
        mov dword [len], eax    ; store the actual length of sentence
    
    ; display the sentence
    push dword msg_p
    call [printf]
    add esp, 4*1
    
    push dword sentence
    push dword format_p
    call [printf]
    add esp, 4*2

    ; exit(0)
    push dword 0      ; push the parameter for exit onto the stack
    call [exit]       ; call exit to terminate the program