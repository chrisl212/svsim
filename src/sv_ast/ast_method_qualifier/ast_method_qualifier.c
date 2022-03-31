#include <stdio.h>
#include "ast_method_qualifier.h"

void ast_method_qualifier_print(ast_method_qualifier_t method_qualifier) {
    const char *val;

    switch (method_qualifier) {
        case AST_METHOD_QUALIFIER_PURE: val = "pure"; break;
        case AST_METHOD_QUALIFIER_VIRTUAL: val = "virtual"; break;
    }

    printf("%s", val);
}
