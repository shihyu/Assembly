/* mactest1.c - An example of a C macro function */
#include <stdio.h>

#define SUM(a, b, result) \
            ((result) = (a) + (b))

int main()
{
   int data1 = 5, data2 = 10;
   int result;
   float fdata1 = 5.0, fdata2 = 10.0;
   float fresult;

   SUM(data1, data2, result);
   printf("The result is %d\n", result);
   SUM(1, 1, result);
   printf("The result is %d\n", result);
   SUM(fdata1, fdata2, fresult);
   printf("The floating result is %f\n", fresult);
   SUM(fdata1, fdata2, result);
   printf("The mixed result is %d\n", result);
   return 0;
}
