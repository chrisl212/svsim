#include <stdio.h>
#include "ast_integer_atom_type.h"

void ast_integer_atom_type_print(ast_integer_atom_type_t integer_atom_type) {
    const char *val;

    switch (integer_atom_type) {
        case AST_INTEGER_ATOM_TYPE_TIME: val = "time"; break;
        case AST_INTEGER_ATOM_TYPE_LONGINT: val = "longint"; break;
        case AST_INTEGER_ATOM_TYPE_BYTE: val = "byte"; break;
        case AST_INTEGER_ATOM_TYPE_SHORTINT: val = "shortint"; break;
        case AST_INTEGER_ATOM_TYPE_INTEGER: val = "integer"; break;
        case AST_INTEGER_ATOM_TYPE_INT: val = "int"; break;
    }

    printf("%s", val);
}
