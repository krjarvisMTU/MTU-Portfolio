#include <stdio.h>
#include <stdbool.h>

int main(void){

        char str[105];
        int charc[105];

        for(int k = 0; k < 105; k++){
                charc[k] = 0;
        }

        bool b = false;
        int charcount = 0;

        while(!b){

                for(int i = 0; i < 105; i++){
                        char c;
                        scanf("%c", &c);
                        str[i] = c;

                        if(c == '\n'){

                                if(i == 0){
                                        b = true;
                                }

                                i++;
                                str[i] = '\0';
                                break;
                        }
                }

                for(int j = 0; j < 105; j++){

                        if(str[j] == '\n'){
                                charc[charcount]++;
                                charcount = 0;
                                break;
                        }


                        if((str[j] >= 65 && str[j] <= 90) || (str[j] >= 96 && str[j] <= 122) || (str[j] == '-') || (str[j] == 39)){
                                charcount++;
                        }

                        else{
                                charc[charcount]++;
                                charcount = 0;
                        }

                }
        }





        for(int m = 1; m < 105; m++){

                if(charc[m] != 0){
                        printf("The total number of %d letter words is : %d\n", m, charc[m]);

                }
        }
}
