/*
This is a C program which draws a 2-D grayscale image and outputs it using the ASCII PMG file format

For this program, I was helped by the CCLC, aswell as watching more indepth videos about certian
C functions, such as sscanf, memset, and stderr, which proved helpful in this assignment

Kyle Jarvis

CS1142, Spring 2023
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
This is the size method which is used to check the command line arguments if there is enough information, and then
take the arguments that specify the width and height, and also check if they are allowed in the 100 * 100 height
*/

int size(const char *arg, int *width, int *height){

        if(sscanf(arg, "%dx%d", width, height) != 2 || *width > 100 || *height > 100){
                return 0;
        }

                return 1;
}

/*
This is the pixel method, which initalizes the pixels within the function
*/

int pixel(unsigned char *image, int width, int height, const char *arg){

        int row, column, value;

        if(sscanf(arg, "%d,%d = %d", &row, &column, &value) != 3 || row < 0 || row >= height || column < 0 || column >= width || value < 0 || value > 255){
                return 0;
        }

        image[row * width + column] = (unsigned char) value;
        return 1;
}

/*
This is the fill_image method, which processes the command line arguments, and sets the pixiels within the function
*/

int fill_image(unsigned char *image, int width, int height, const char *arg){

        int value;

        if(sscanf(arg, "%d", &value) != 1 || value < 0 || value > 255){

                return 0;

        }

        memset(image, value, width * height);
        return 1;
}

/*
This is a method which allows us to actually output our image
thanks to the methods above, having the pixels initialized, aswell as our image created
*/

void output(const unsigned char *image, int width, int height){

        printf("P2\n");
        printf("%d %d\n", width, height);
        printf("255\n");

        for(int i = 0; i < height; i++){

                for(int j = 0; j < width; j++){
                        printf("%d ", image[i * width + j]);
                }

                printf("\n");
        }
}

/*
This is the main method, where the image is printed out from other methods
*/

int main(int argc, char *argv[]){

        if(argc < 2){

                fprintf(stderr, "Error: Missing Image Size Argument\n");
                return 1;
        }

        int width, height;

        if(!size(argv[1], &width, &height)){

                fprintf(stderr, "Error: Invalid Image Size Argument\n");
                return 1;
        }

        unsigned char *image = calloc(width * height, sizeof(unsigned char));

        if(!image){

                fprintf(stderr, "Error: Memory Allocation Falied\n");
                return 1;
        }

        for(int i = 2; i < argc; i++){

                if(!pixel(image, width, height, argv[i]) && !fill_image(image, width, height, argv[i])){

                        fprintf(stderr, "Error: Invalid Command Line Argument '%s'\n", argv[i]);
                        free(image);
                        return 1;
                }
        }

        output(image, width, height);

        free(image);

        return 0;
}
