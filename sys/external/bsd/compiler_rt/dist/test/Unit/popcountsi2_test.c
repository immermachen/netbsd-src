//===-- popcountsi2_test.c - Test __popcountsi2 ---------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file tests __popcountsi2 for the compiler_rt library.
//
//===----------------------------------------------------------------------===//

#include "int_lib.h"
#include <stdio.h>
#include <stdlib.h>

// Returns: count of 1 bits

si_int __popcountsi2(si_int a);

int naive_popcount(si_int a)
{
    int r = 0;
    for (; a; a = (su_int)a >> 1)
        r += a & 1;
    return r;
}

int test__popcountsi2(si_int a)
{
    si_int x = __popcountsi2(a);
    si_int expected = naive_popcount(a);
    if (x != expected)
        printf("error in __popcountsi2(0x%X) = %d, expected %d\n",
               a, x, expected);
    return x != expected;
}

char assumption_2[sizeof(si_int)*CHAR_BIT == 32] = {0};

int main()
{
    if (test__popcountsi2(0))
        return 1;
    if (test__popcountsi2(1))
        return 1;
    if (test__popcountsi2(2))
        return 1;
    if (test__popcountsi2(0xFFFFFFFD))
        return 1;
    if (test__popcountsi2(0xFFFFFFFE))
        return 1;
    if (test__popcountsi2(0xFFFFFFFF))
        return 1;
    int i;
    for (i = 0; i < 10000; ++i)
        if (test__popcountsi2(rand()))
            return 1;

   return 0;
}
