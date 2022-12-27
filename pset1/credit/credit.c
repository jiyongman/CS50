#include <cs50.h>
#include <stdio.h>

bool is_valid(long number);

int main(void)
{
    long number;
    do
    {
        number = get_long("Number: ");
    }
    while (number < 0);

    if (is_valid(number))
    {
        if (number / 10000000000000 == 34 || number / 10000000000000 == 37)
        {
            printf("AMEX\n");
        }
        else if (number / 100000000000000 >= 51 && number / 100000000000000 <= 55)
        {
            printf("MASTERCARD\n");
        }
        else if (number / 1000000000000 == 4 || number / 1000000000000000 == 4)
        {
            printf("VISA\n");
        }
        else
        {
            printf("INVALID\n");
        }
    }
    else
    {
        printf("INVALID\n");
    }
}

bool is_valid(long number)
{
    int sum = 0;
    int i = 0;

    while (number > 0)
    {
        int digit = number % 10;

        if (i % 2 == 0)
        {
            sum += digit;
        }
        else
        {
            if (digit * 2 >= 10)
            {
                sum += digit * 2 / 10;
                sum += digit * 2 % 10;
            }
            else
            {
                sum += digit * 2;
            }
        }
        number /= 10;
        i++;
    }

    if (sum % 10 == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}
