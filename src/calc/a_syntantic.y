%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

#include "config.h"
#include "lex.yy.h"

extern int yylex();
void yyerror(char* s);
%}

%union {
float	num;
char	*id;
}

%start input

%token <num> T_NUM
%token <id> T_VAR

// Indiscutiblemente en este orden
%token T_END
%token T_PRI
%token T_PRD
%right T_EQL
%left T_MAS
%left T_MNS
%left T_TMS
%left T_DIV
%left T_PRI
%left T_NEG
%right T_POW

%type <num> EXP
%type <num> SET
%type <num> OP

%%

input: /* cadena vacía */ { if (interactuable) printf ("CALC > ");}
  | input line { if (interactuable) printf ("CALC > ");}
;

line:    OP T_END { printf ("Result: %.4f\n",$1); }
        | SET T_END { printf ("Setted to: %.4f\n",$1); }
        | EXP T_END { printf ("Result: %.4f\n",$1); }
        | T_END      {;}
        | error T_END { ; }

EXP:    T_NUM   {$$ = $1;}
        | T_VAR   {
                    struct item *i = ht_get(hashtable, lowerstr($1));
                    if(i){
                        $$ = i->value;
                    } else {
                        yyerror(E_INITVAR);
                    }
                  }
        | SET
        | T_VAR T_PRI EXP T_PRD {
                    struct item *i = ht_get(hashtable, lowerstr($1));
                    if(i){
                        if(i->func){
                            $$ = i->func($3);
                        } else {
                            yyerror(E_NOFUNC);
                        }
                    } else {
                        yyerror(E_NOFUNC);
                    }
                        }
        | OP
        | T_PRI EXP T_PRD {$$ = $2;}
;

OP:     EXP T_MAS EXP   {$$ = $1 + $3;}
        | EXP T_MNS EXP {$$ = $1 - $3;}
        | EXP T_TMS EXP {$$ = $1 * $3;}
        | EXP T_DIV EXP {if($3 != 0){$$ = $1 / $3;} else { yyerror(E_DIVZERO); } }
        | T_MNS EXP %prec T_NEG {$$ = -$2;}
        | EXP T_POW EXP {$$ = pow($1, $3);}
;

SET:    T_VAR T_EQL EXP   {
                        struct item *out;
                        out = malloc(sizeof(struct item));
                        out->code = VAR;
                        out->instance = strdup(lowerstr($1));
                        out->value = $3;
                        $$ = $3;
                        out->func = NULL;
                        ht_set(hashtable, out->instance, out);
                      }
;

%%

void yyerror(char* s){
  printf ("Error(yyerror): %s\n", s);
}

int main(int argc,char **argv){
  hashtable = ht_create(65536);
  ht_init();
  ht_print(hashtable);

  if(argc > 1){
      if(!strcmp(argv[1], "--help")){
        help();
      }else{
        readFile(argv[1]);
      }
    }

  yyparse();

  ht_print(hashtable);
  ht_free(hashtable);
  return 0;
}
