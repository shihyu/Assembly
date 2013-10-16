/* goodprog.c - An example of passing input values in the proper order */
#include <stdio.h>

double testfunc(double, int);

int main()
{
        double data1 = 3.14159;
        int data2 = 10;
        double result;

        result = testfunc(data1, data2);
        printf("The proper result is %f\n", result);
        return 0;
}
