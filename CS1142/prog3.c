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



        int minium;
        int maxium;
        int mode = 0;
        int comp = 0;

        for(int m = 104; m > 0; m--){
                if(charc[m] != 0){
                        minium = m;
                }
        }


        for(int n = 1; n < 105; n++){
                if(charc[n] != 0){
                        maxium = n;
                }
        }

        for(int o = 1; o < 105; o++){

                if(charc[o] > comp){
                        mode = o;
                        comp = charc[o];
                }
        }

        printf("The minium is %d, and the maxium is %d, and the mode is %d ", minium, maxium, mode);
}
