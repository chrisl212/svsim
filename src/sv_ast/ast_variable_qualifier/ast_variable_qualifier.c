#include <stdio.h>
#include "ast_variable_qualifier.h"

void ast_variable_qualifier_print(ast_variable_qualifier_t variable_qualifier) {
    const char *val;

    switch (variable_qualifier) {
        case AST_VARIABLE_QUALIFIER_RAND: val = "rand"; break;
        case AST_VARIABLE_QUALIFIER_CONST: val = "const"; break;
        case AST_VARIABLE_QUALIFIER_VAR: val = "var"; break;
        case AST_VARIABLE_QUALIFIER_RANDC: val = "randc"; break;
    }

    printf("%s", val);
}
