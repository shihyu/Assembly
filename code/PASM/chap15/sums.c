/* sums.c - An example of optimizing for-next loops */
#include <stdio.h>

int sums(int i)
{
        int j, sum = 0;
        for(j = 1; j <= i; j++)
                sum = sum + j;
        return sum;
}

int main()
{
        int i = 10;
        printf("Value: %d   Sum: %d\n", i, sums(i));
        return 0;
}
