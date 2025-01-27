#include <stdio.h>

extern float expo(float a, float b);

int main(int argc, char** argv){
    printf("hello rofl\n");
    float num = 48.4f;
    printf("Num:  %f, pow: %f \n",num, expo(num, 15.6f));
    return 0;
}