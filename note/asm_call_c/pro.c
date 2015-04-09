#include<stdio.h>
int swapint(int *a,int *b)
{
    int c;
    char *str="success!!";
    c=*a;
    *a=*b;
    *b=c;
    puts(str);                //用puts可以輸出
    puts("end!");            //用puts可以輸出
    printf("output??");        //用printf會造成此句無輸出，原因：緩衝區沒滿，用\n清空緩衝區即可造成輸出。
    return 0;
}
