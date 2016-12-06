%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#include "config.h"
#include "lex.yy.h"
#include "a_syntantic.tab.h"

char *filename = "";
%}

%option noyywrap
%option caseless

ENTERO              [[:digit:]_]+
FLOAT               [[:digit:]]*\.[[:digit:]]+
EXP                 [eE][-+]?[[:digit:]_]+
ID                  [[:alnum:]_]*
IGNORAR             [[:blank:]]

%x load
%s LOAD_FILE

%%

<LOAD_FILE>{
[^\n]*            {
                    filename = yytext;
                  }
\n                {
                    BEGIN(INITIAL);
                    remove_char_from_string('\n', filename);
                    remove_char_from_string(' ', filename);
                    readFile(filename);
                  }
}
<INITIAL>{
"exit"              {yyterminate(); return 1;}
"clear"             {clearscr(); return 1;}
"show table"        {ht_print(hashtable); return 1;}
"show help"         {help(); return 1;}
"load"              {BEGIN(LOAD_FILE);}

{IGNORAR}           {}
{FLOAT}{EXP}        { yylval.num=atof(yytext); return T_NUM; }
{ENTERO}{EXP}       { yylval.num=atof(yytext); return T_NUM; }
{FLOAT}             { yylval.num=atof(yytext); return T_NUM; }
{ENTERO}            { yylval.num=atof(yytext); return T_NUM; }
{ID}                {
                        yylval.id = (char *) malloc(sizeof (yytext));
                        yylval.id = strdup(yytext);
                        return T_VAR;
                    }
";"		            {return T_END;}
\n		            {return T_END;}
\r		            {}
"="                 {return T_EQL;}
"("                 {return T_PRI;}
")"                 {return T_PRD;}
"+"                 {return T_MAS;}
"-"                 {return T_MNS;}
"*"                 {return T_TMS;}
"/"                 {return T_DIV;}
"^"                 {return T_POW;}
.                   {printf("ERROR-> Caracter no reconocido");};
}

<<EOF>>		        {yyterminate();}

%%

void readFile(char* fichero){
    interactuable = false;
    printf("< Reading file>\n");
    printf("  Filename: <%s>\n", fichero);
    if(fichero != NULL){
        yyin = fopen(fichero, "r");

        if(yyin != NULL){
                yyrestart(yyin);
                yyparse();
        } else {
                printf("  Error: Can\'t read file %s\n", fichero);
        }
    } else {
        printf("  Error: Can\'t open file %s\n", fichero);
    }

    printf("</Reading file>\n");

    interactuable = true;
    yyin = stdin;
    yyrestart(yyin);
    yyparse();

    prompt();
}