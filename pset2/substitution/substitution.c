#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>

int main(int argc, string argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }
    else if (strlen(argv[1]) != 26)
    {
        printf("Key must contain 26 characters.\n");
        return 1;
    }
    else
    {
        bool check[26] = {};
        string key = argv[1];

        for (int i = 0; i < 26; i++)
        {
            check[toupper(key[i]) - 'A'] = true;
        }

        for (int i = 0; i < 26; i++)
        {
            if (!check[i])
            {
                printf("Key must contain 26 characters.\n");
                return 1;
            }
        }

        string text = get_string("plaintext:  ");

        for (int i = 0, n = strlen(text); i < n; i++)
        {
            if (isalpha(text[i]))
            {
                if (isupper(text[i]))
                {
                    text[i] = toupper(key[text[i] - 'A']);
                }
                else
                {
                    text[i] = tolower(key[text[i] - 'a']);
                }
            }
        }

        printf("ciphertext: %s\n", text);
        return 0;
    }
}
