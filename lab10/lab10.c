#include <stdio.h>

// the function declared in modulConcatenate.asm
int asmConcat(char sir[], char sirR[]);

// the function used for reading a string from keyboard

// global string accessed from asmConcat
char str3[] = "0011223344";
chat str2[] = "2344455677";

int main()
{
    char str1[11];
    char strRez[31] = "";
    int lenStrRez = 0;

   

    lenStrRez = asmConcat(str1, strRez);
    printf("\nResult string of length %d:\n%s", lenStrRez, strRez);
    return 0;
}

