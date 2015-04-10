/* mactest2.c - An example of using inline assembly macros in a program */
#include <stdio.h>

#define GREATER(a, b, result) ({ \
    asm("cmp %1, %2\n\t" \
        "jge 0f\n\t" \
        "movl %1, %0\n\t" \
        "jmp 1f\n\t" \
        "0:\n\t" \
        "movl %2, %0\n\t" \
        "1:" \
        :"=r"(result) \
        :"r"(a), "r"(b)); })

int main()
{
   int data1 = 10;
   int data2 = 20;
   int result;

   GREATER(data1, data2, result);
   printf("a = %d, b = %d    result: %d\n", data1, data2, result);

   data1 = 30;
   GREATER(data1, data2, result);
   printf("a = %d, b = %d    result: %d\n", data1, data2, result);
   return 0;
}
