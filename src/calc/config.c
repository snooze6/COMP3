#include "config.h"
#include <math.h>
#include <stdio.h>
#include <ctype.h>

bool interactuable = true;

void clearscr(){
    for (int x = 0; x < 10; x++ ){
        printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    }
//#if defined(__linux__) || defined(__unix__) || defined(__APPLE__)
//    system("clear");
//#endif
//
//#if defined(_WIN32) || defined(_WIN64)
//    system("cls");
//#endif
}

void help(){
    printf("\nAYUDA:");

    printf("\n  Mostrar ayuda");
    printf("\n    -Escrbir el comando \"show help\" para ver Esta ayuda\n");

    printf("\n  Constantes");
    printf("\n    -Pi");
    printf("\n    -E");
    printf("\n    -L (Numero de Avogadro)\n");

    printf("\n  Funciones");
    printf("\n    -Sin (seno)");
    printf("\n    -Cos (coseno)");
    printf("\n    -Atan (arco tangente)");
    printf("\n    -Log (logaritmo)");
    printf("\n    -Exp (exponencial");
    printf("\n    -Sqrt (raiz cuadrada)\n");

    printf("\n  Cargar Archivo");
    printf("\n    -Escribir el comando \"load filename\"\n");

    printf("\n  Tabla de simbolos");
    printf("\n    -Escrbir el comando \"show table\" para ver el contenido de la tabla de simbolos\n");

    printf("\n  Limpiar pantalla");
    printf("\n    -Escrbir el comando \"clear\" para ver el contenido de la tabla de simbolos\n");

    printf("\n  Terminar el programa");
    printf("\n    -Escribir el comando \"exit\"\n");

    printf("\n");
}

void prompt(){
    printf("CALC> ");
}

void ht_init(){
    struct item *out;
    // CONSTANTES
    out = malloc(sizeof(struct item));
    out->code = VAR; out->instance = "pi"; out->value = 3.14; out->func = NULL;
    ht_set(hashtable, "pi", out);
    out = malloc(sizeof(struct item));
    out->code = VAR; out->instance = "e"; out->value = 2.71; out->func = NULL;
    ht_set(hashtable, "e", out);
    out = malloc(sizeof(struct item));
    out->code = VAR; out->instance = "l"; out->value = 6.023*pow(10, 23); out->func = NULL;
    ht_set(hashtable, "l", out);

    out = malloc(sizeof(struct item));
    out->code = FUNC; out->instance = "sin"; out->value = 0; out->func = sin;
    ht_set(hashtable, "sin", out);
    out = malloc(sizeof(struct item));
    out->code = FUNC; out->instance = "cos"; out->value = 0; out->func = cos;
    ht_set(hashtable, "cos", out);
    out = malloc(sizeof(struct item));
    out->code = FUNC; out->instance = "atan"; out->value = 0; out->func = atan;
    ht_set(hashtable, "atan", out);
    out = malloc(sizeof(struct item));
    out->code = FUNC; out->instance = "log"; out->value = 0; out->func = log;
    ht_set(hashtable, "log", out);
    out = malloc(sizeof(struct item));
    out->code = FUNC; out->instance = "exp"; out->value = 0; out->func = exp;
    ht_set(hashtable, "exp", out);
    out = malloc(sizeof(struct item));
    out->code = FUNC; out->instance = "sqrt"; out->value = 0; out->func = sqrt;
    ht_set(hashtable, "sqrt", out);

    //insertaVarTabla($1, VAR, $3, NULL); $$ = $3;
}

char * lowerstr(char * str){
    for(int i = 0; str[i]; i++){
        str[i] = tolower(str[i]);
    }
    return str;
}

void remove_char_from_string(char c, char *str) {
    int i=0;
    int len = strlen(str)+1;

    for(i=0; i<len; i++)
    {
        if(str[i] == c)
        {
            // Move all the char following the char "c" by one to the left.
            strncpy(&str[i],&str[i+1],len-i);
        }
    }
}