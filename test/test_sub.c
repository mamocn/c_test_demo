#include <criterion/criterion.h>
#include <string.h>
#include "sub.h"

Test(sample, test)
{
    cr_expect(strlen("Test") == 4, "Expected \"Test\" to have a length of 4.");
}

Test(sample, test1)
{
    cr_expect(sub(1,2) == 3,"三大件发基金分");
}