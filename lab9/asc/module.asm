bits 32                         
segment code use32 public code
global findmin

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