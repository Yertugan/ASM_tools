%ifndef _FINDMIN_ASM_ ; continue if _FACTORIAL_ASM_ is undefined
%define _FINDMIN_ASM_ ; make sure that it is defined
                        ; otherwise, %include allows only one inclusion

;define the function
findmin:
	cmp edx, ebx 
    jbe first
    jmp second
    
    first:
        mov eax, edx
        jmp finish
        
    second:
        mov eax, ebx
    
    finish:
        mov dword [esp+4], eax
    
    ret 

%endif