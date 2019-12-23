bits 32

extern _readString
extern _str2
; in Windows, the nasm directive import can be used only for obj files!! we will create a win32 file, the printf function will be imported as follows (according to the NASM documentation)
extern _printf
; informing the assembler that we want to make the _asmConcat function available for other modules
global _asmConcat
; the linkeditor can use the public data segment also for data from outside
segment data public data use32
;Two strings containing characters are given. Calculate and display the result of the concatenation of all characters of type decimal number from the second string, and then followed by those from the first string, and vice versa, the result of concatenating the characters from the first string after those from the second string.
    lenRez                dd        0
    resultStringAddress     dd        0
    paramStringAddress        dd        0
    readStringAddress        dd        0
    message                 db        "String 2: 3334445556", 0
; the assembly code is included in segment public, possible to be shared with another extern code
segment code public code use32
; int asmConcat(char[], char[])
; stdcall convention
_asmConcat:
    ; creating a stack frame for the called program
    push ebp
    mov ebp, esp
    
    ; reserving space on the stack for local variables
    sub esp, 4 * 3                    ; reserving 4*3 bytes on the stack for the string read from keyboard
    ; arguments passed to the asmConcat function using the stack 
	; at the location [ebp+4] we have the return address (the value of EIP at the moment of the call)
    ; at the location [ebp] we have the value of ebp for the caller
    mov eax, [ebp + 8]
    mov [paramStringAddress], eax
    mov eax, [ebp + 12]
    mov [resultStringAddress], eax
    ; store the address of the string that is read
    mov [readStringAddress], ebp
    sub dword [readStringAddress], 4*3
       
    
    push dword message
    call _printf
    add esp, 4*1
    
    
    cld
    mov edi, [resultStringAddress]
    mov esi, [paramStringAddress]
    mov ecx, 10
    rep movsb
    ; copy the string from the global variable from the C program in the result string
   
    add dword [lenRez], 10
    mov esi, _str2
    mov ecx, 10
    rep movsb
    add dword [lenRez], 10
    
    ; delete the space reserved on the stack
    ; !! we did not store the values of the registers before executing _asmConcat, if we wishh to do that we can use the instruction PUSHAD and restore them using POPAD
	add esp, 4 * 3
    ; restore the stack frame for the caller program
    mov esp, ebp
    pop ebp
    ; the two instruction which restore the stack frame can be replaced with the instruction leave
    ; return the length of the obtained string as a result in eax 
    mov eax, [lenRez]
    ret
    ; stdcall convention - it is the responsibility of the caller program to free the parameters of the function from the stack