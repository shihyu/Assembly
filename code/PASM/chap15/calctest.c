/* calctest.c - An example of pre-calculating values */
#include <stdio.h>

int main()
{
        int a = 10;
        int b, c;
        a = a + 15;
        b = a + 200;
        c = a + b;
        printf("The result is %d\n", c);
        return 0;
}
