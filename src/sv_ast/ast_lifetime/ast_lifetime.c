#include <stdio.h>
#include "ast_lifetime.h"

void ast_lifetime_print(ast_lifetime_t lifetime) {
    const char *val;

    switch (lifetime) {
        case AST_LIFETIME_AUTOMATIC: val = "automatic"; break;
        case AST_LIFETIME_STATIC: val = "static"; break;
    }

    printf("%s", val);
}
