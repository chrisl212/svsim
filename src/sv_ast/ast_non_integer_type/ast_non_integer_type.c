#include <stdio.h>
#include "ast_non_integer_type.h"

void ast_non_integer_type_print(ast_non_integer_type_t non_integer_type) {
    const char *val;

    switch (non_integer_type) {
        case AST_NON_INTEGER_TYPE_SHORTREAL: val = "shortreal"; break;
        case AST_NON_INTEGER_TYPE_REAL: val = "real"; break;
        case AST_NON_INTEGER_TYPE_REALTIME: val = "realtime"; break;
    }

    printf("%s", val);
}
