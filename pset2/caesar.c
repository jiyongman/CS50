#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

bool only_digits(string s);

int main(int argc, string argv[])
{
    if (argc != 2 || !only_digits(argv[1]))
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }
    else
    {
        int key = atoi(argv[1]) % 26;

        string text = get_string("plaintext:  ");

        for (int i = 0, n = strlen(text); i < n; i++)
        {
            if (isupper(text[i]))
            {
                if (text[i] + key > 'Z')
                {
                    text[i] -= 26;
                }
                text[i] += key;
            }
            else if (islower(text[i]))
            {
                if (text[i] + key > 'z')
                {
                    text[i] -= 26;
                }
                text[i] += key;u
            }
        }

        printf("ciphertext: %s\n", text);
        return 0;
    }
}

bool only_digits(string s)
{
    for (int i = 0, n = strlen(s); i < n; i++)
    {
        if (!isdigit(s[i]))
        {
            return false;
        }
    }

    return true;
}
