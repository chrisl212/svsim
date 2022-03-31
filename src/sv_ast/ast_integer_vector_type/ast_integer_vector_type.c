#include <stdio.h>
#include "ast_integer_vector_type.h"

void ast_integer_vector_type_print(ast_integer_vector_type_t integer_vector_type) {
    const char *val;

    switch (integer_vector_type) {
        case AST_INTEGER_VECTOR_TYPE_REG: val = "reg"; break;
        case AST_INTEGER_VECTOR_TYPE_BIT: val = "bit"; break;
        case AST_INTEGER_VECTOR_TYPE_LOGIC: val = "logic"; break;
    }

    printf("%s", val);
}
