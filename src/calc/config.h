#ifndef P1_COMP_CONFIG_H
#define P1_COMP_CONFIG_H

#include "external/model/hash.h"
//#include "helpers/logger.h"
#include <stdbool.h>

#define ETAG "[+] -"
#define VTAG "[-] -"
#define WTAG "[*] -"


#define COLOR_RED     "\x1b[31m"
#define COLOR_GREEN   "\x1b[32m"
#define COLOR_YELLOW  "\x1b[33m"
#define COLOR_BLUE    "\x1b[34m"
#define COLOR_MAGENTA "\x1b[35m"
#define COLOR_CYAN    "\x1b[36m"
#define COLOR_RESET   "\x1b[0m"

#define VAR    400
#define FUNC        401
#define CONSTANT    402

#define E_FILE "Cannot read file"
#define E_DIVZERO "Div by zero"
#define E_INITVAR "Undefined var"
#define E_NOFUNC "Undefined function"

hashtable_t *hashtable;
extern bool interactuable;

void clearscr();
void help();
void prompt();
void ht_init();
char *lowerstr(char * str);
void remove_char_from_string(char c, char *str);

#endif //P1_COMP_CONFIG_H
