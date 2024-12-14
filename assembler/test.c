#include <stdio.h>

unsigned char arr[4];
int main(){
    float num1 = 12.12345;
    arr[0] = *((unsigned char*)(&num1) + 0);
    arr[1] = *((unsigned char*)(&num1) + 1);
    arr[2] = *((unsigned char*)(&num1) + 2);
    arr[3] = *((unsigned char*)(&num1) + 3);
    printf("%f", *((float*)&arr));
    
    return 0;
}