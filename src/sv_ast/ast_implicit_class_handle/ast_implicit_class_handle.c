#include <stdio.h>
#include "ast_implicit_class_handle.h"

void ast_implicit_class_handle_print(ast_implicit_class_handle_t implicit_class_handle) {
    const char *val;

    switch (implicit_class_handle) {
        case AST_IMPLICIT_CLASS_HANDLE_THIS: val = "this"; break;
        case AST_IMPLICIT_CLASS_HANDLE_SUPER: val = "super"; break;
        case AST_IMPLICIT_CLASS_HANDLE_FIXME: val = "fixme"; break;
    }

    printf("%s", val);
}
