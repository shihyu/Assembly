/* jmptest2.c - An example of using generic jumps in inline assembly */
#include <stdio.h>

int main()
{
   int a = 10;
   int b = 20;
   int result;

   asm("cmp %1, %2\n\t"
       "jge 0f\n\t"
       "movl %1, %0\n\t"
       "jmp 1f\n"
       "0:\n\t"
       "movl %2, %0\n"
       "1:"
       :"=r"(result)
       :"r"(a), "r"(b));

   printf("The larger value is %d\n", result);
   return 0;
}
