#include <stdio.h>

extern float expo(float a, float b);

int main(int argc, char** argv){
    float base, exp;
    printf("hello rofl\n");
    printf("enter base: ");
    scanf("%f", &base);
    printf("enter power: ");
    scanf("%f", &exp);
    printf("Num:  %f, exp: %f, pow: %f \n",base, exp, expo(base, exp));
    return 0;
}