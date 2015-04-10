/* mathtest.c - An example of using multiple input values */
#include <stdio.h>

float fpmathfunc(float, int, float, float, float, int, float, float);

int main()
{
        float value1 = 43.65;
        int value2 = 22;
        float value3 = 76.34;
        float value4 = 3.1;
        float value5 = 12.43;
        int value6 = 6;
        float value7 = 140.2;
        float value8 = 94.21;
        float result;
        result = fpmathfunc(value1, value2, value3, value4,
                            value5, value6, value7, value8);
        printf("The final result is %f\n", result);
        return 0;
}
