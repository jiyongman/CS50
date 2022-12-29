#include <math.h>

#include "helpers.h"

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            int avg = round((image[i][j].rgbtRed + image[i][j].rgbtGreen + image[i][j].rgbtBlue) / 3.0);

            image[i][j].rgbtRed = avg;
            image[i][j].rgbtGreen = avg;
            image[i][j].rgbtBlue = avg;
        }
    }

    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)
        {
            RGBTRIPLE tmp = image[i][j];
            image[i][j] = image[i][width - 1 - j];
            image[i][width - 1 - j] = tmp;
        }
    }

    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            double sumRed = 0;
            double sumGreen = 0;
            double sumBlue = 0;
            double cnt = 0.0;

            for (int row = -1; row <= 1; row++)
            {
                for (int col = -1; col <= 1; col++)
                {
                    if ((i + row >= 0 && i + row < height) && (j + col >= 0 && j + col < width))
                    {
                        sumRed += image[i + row][j + col].rgbtRed;
                        sumGreen += image[i + row][j + col].rgbtGreen;
                        sumBlue += image[i + row][j + col].rgbtBlue;
                        cnt++;
                    }
                }
            }

            copy[i][j].rgbtRed = round(sumRed / cnt);
            copy[i][j].rgbtGreen = round(sumGreen / cnt);
            copy[i][j].rgbtBlue = round(sumBlue / cnt);
        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = copy[i][j];
        }
    }

    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    double Gx[3][3] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
    double Gy[3][3] = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};
    RGBTRIPLE copy[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            double GxRed = 0;
            double GyRed = 0;
            double GxGreen = 0;
            double GyGreen = 0;
            double GxBlue = 0;
            double GyBlue = 0;

            for (int row = -1; row <= 1; row++)
            {
                for (int col = -1; col <= 1; col++)
                {
                    if ((i + row >= 0 && i + row < height) && (j + col >= 0 && j + col < width))
                    {
                        GxRed += image[i + row][j + col].rgbtRed * Gx[row + 1][col + 1];
                        GyRed += image[i + row][j + col].rgbtRed * Gy[row + 1][col + 1];
                        GxGreen += image[i + row][j + col].rgbtGreen * Gx[row + 1][col + 1];
                        GyGreen += image[i + row][j + col].rgbtGreen * Gy[row + 1][col + 1];
                        GxBlue += image[i + row][j + col].rgbtBlue * Gx[row + 1][col + 1];
                        GyBlue += image[i + row][j + col].rgbtBlue * Gy[row + 1][col + 1];
                    }
                }
            }

            copy[i][j].rgbtRed = round(sqrt(pow(GxRed, 2) + pow(GyRed, 2))) > 255 ? 255 : round(sqrt(pow(GxRed, 2) + pow(GyRed, 2)));
            copy[i][j].rgbtGreen = round(sqrt(pow(GxGreen, 2) + pow(GyGreen, 2))) > 255 ? 255 : round(sqrt(pow(GxGreen, 2) + pow(GyGreen, 2)));
            copy[i][j].rgbtBlue = round(sqrt(pow(GxBlue, 2) + pow(GyBlue, 2))) > 255 ? 255 : round(sqrt(pow(GxBlue, 2) + pow(GyBlue, 2)));
        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = copy[i][j];
        }
    }

    return;
}
