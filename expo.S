.intel_syntax noprefix
.global expo
.text

expo:
    movss xmm5, xmm0
    movss xmm3, xmm1


    movss xmm15, xmm5
    jmp .LexponentExtraction



.LexponentExtraction:
    mov r8, 0x7F800000
    mov r9, 127
    movd xmm6, r8
    movd xmm7, r9
    pand xmm5, xmm6
    psrld xmm5, 23
    psubw xmm5, xmm7
    cvtdq2ps xmm5, xmm5
    movss xmm14, xmm5
    jmp .Lmantice

.Lmantice:
    
    mov r8, 0x007FFFFF
    mov r9, 0x3F800000
    mov r10, 0x3F800000
    movd xmm6, r8
    movd xmm7, r9
    movd xmm8, r10
    pand xmm15, xmm6
    paddd xmm15, xmm7
    subss xmm15, xmm8

    jmp .Lln

.Lln:


    //ln(1+x) = a1*x + a2*x^2 + a3*x^3 + a4*x^4 + a5*x^5 + a6*x^6 + a7*x^7

    mov r8, 0x3F7FFEC1
    mov r9, 0xBEFFBAED
    mov r10, 0x3EA810E9
    mov r11, 0xBE675C07

    movd xmm6, r8   //a1
    movd xmm7, r9   //a2
    movd xmm8, r10  //a3
    movd xmm9, r11  //a4

    movss xmm13, xmm15    //xmm10 - power of x (x, x^2, x^3 ...)
    pxor xmm5, xmm5   //xmm0 - answer

    
    mulss xmm6, xmm13
    addss xmm5, xmm6

    mulss xmm13, xmm15
    mulss xmm7, xmm13
    addss xmm5, xmm7

    mulss xmm13, xmm15
    mulss xmm8, xmm13
    addss xmm5, xmm8

    mulss xmm13, xmm15
    mulss xmm9, xmm13
    addss xmm5, xmm9

    mov r9, 0x3E09F87F
    mov r10, 0xBD62131B
    mov r11, 0x3C309C15
    movd xmm6, r9   //a5
    movd xmm7, r10  //a6
    movd xmm8, r11  //a7

    mulss xmm13, xmm15
    mulss xmm6, xmm13
    addss xmm5, xmm6

    mulss xmm13, xmm15
    mulss xmm7, xmm13
    addss xmm5, xmm7

    mulss xmm13, xmm15
    mulss xmm8, xmm13
    addss xmm5, xmm8

    jmp .Lpower

.Lpower:
    mov r8, 0x3F317218  //ln(2)
    movd xmm6, r8
    mulss xmm6, xmm14
    addss xmm5, xmm6
    mulss xmm5, xmm3 

    jmp .Ldivision

    //e^k = e^(2^n * e^r)
.Ldivision:
    mov r8, 0x3F317218  //ln(2)
    mov r9, 0x3FB8AA3B  //1/ln(2)
    mov r10, 0x3F800000
    movd xmm6, r8
    movd xmm7, r9
    movd xmm14, r10

    movss xmm15, xmm5       //xmm15 - k
    mulss xmm5, xmm7
    cvttps2dq xmm5, xmm5
    movss xmm7, xmm5
    pslld xmm7, 23
    paddd xmm14, xmm7   //xmm14 - 2^n
    //cvtdq2ps xmm14, xmm14\
    
    //jmp .Lret

    cvtdq2ps xmm5, xmm5
    mulss xmm6, xmm5
    subss xmm15, xmm6       //xmm15 - r

    jmp .Lexponent


.Lexponent:

    // e^r = 1 + r + a1*r^2 + a2*r^3 + a3*r^4 + a4*r^5 + a5*r^6 + a6*r^7 + a7*r^8  +a8*r^9

    mov r8, 0x3F800000
    mov r9, 0x3F000000
    mov r10, 0x3E2AAAAB
    mov r11, 0x3D2AAAAB

    movd xmm6, r8   //1
    movd xmm7, r9   //a1
    movd xmm8, r10  //a2
    movd xmm9, r11  //a3

    movss xmm13, xmm15
    pxor xmm5, xmm5 //xmm5 - answer

    addss xmm5, xmm6

    addss xmm5, xmm13

    mulss xmm13, xmm15
    mulss xmm7, xmm13
    addss xmm5, xmm7

    mulss xmm13, xmm15
    mulss xmm8, xmm13
    addss xmm5, xmm8

    mulss xmm13, xmm15
    mulss xmm9, xmm13
    addss xmm5, xmm9

    mov r8, 0x3C088889
    mov r9, 0x3AB60B61
    mov r10, 0x39500D01
    movd xmm6, r8   //a4
    movd xmm7, r9   //a5
    movd xmm8, r10  //a6

    mulss xmm13, xmm15
    mulss xmm6, xmm13
    addss xmm5, xmm6

    mulss xmm13, xmm15
    mulss xmm7, xmm13
    addss xmm5, xmm7

    mulss xmm13, xmm15
    mulss xmm8, xmm13
    addss xmm5, xmm8

    mov r8, 0x37D00D01
    mov r9, 0x3638EF1D
    mov r10, 0x34942D27
    movd xmm6, r8   //a7
    movd xmm7, r9   //a8
    movd xmm8, r10 //a10

    mulss xmm13, xmm15
    mulss xmm6, xmm13
    addss xmm5, xmm6

    mulss xmm13, xmm15
    mulss xmm7, xmm13
    addss xmm5, xmm7

    mulss xmm13, xmm15
    mulss xmm8, xmm13
    addss xmm5, xmm8


    jmp .Lfin

.Lfin:
    mulss xmm5, xmm14
    jmp .Lret

.Lret:
    //cvtdq2ps xmm7, xmm7
    movss xmm0, xmm5
    ret




