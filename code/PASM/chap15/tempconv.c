/* tempconv.c - An example for viewing assembly source code */
#include <stdio.h>

float convert(int deg)
{
        float result;
        result = (deg - 32.) / 1.8;
        return result;
}

int main()
{
        int i = 0;
        float result;
        printf("    Temperature Conversion Chart\n");
        printf("Fahrenheit       Celsius\n");
        for(i = 0; i < 230; i = i + 10)
        {
                result = convert(i);
                printf("  %d             %5.2f\n", i, result);
        }
        return 0;
}
