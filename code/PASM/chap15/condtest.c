/* condtest.c - An example of optimizing if-then code */
#include <stdio.h>

int conditiontest(int test1, int test2)
{
        int result;
        if (test1 > test2)
        {
                result = test1;
        } else if (test1 < test2)
        {
                result = test2;
        }else
        {
                result = 0;
        }
        return result;
}

int main()
{
        int data1 = 10;
        int data2 = 30;
        printf("The result is %d\n", conditiontest(data1, data2));
        return 0;
}
