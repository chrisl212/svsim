#include <stdio.h>
#include "ast_strength1.h"

void ast_strength1_print(ast_strength1_t strength1) {
    const char *val;

    switch (strength1) {
        case AST_STRENGTH1_PULL1: val = "pull1"; break;
        case AST_STRENGTH1_STRONG1: val = "strong1"; break;
        case AST_STRENGTH1_WEAK1: val = "weak1"; break;
        case AST_STRENGTH1_SUPPLY1: val = "supply1"; break;
    }

    printf("%s", val);
}
