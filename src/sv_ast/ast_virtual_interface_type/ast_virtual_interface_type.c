#include <stdio.h>
#include "ast_virtual_interface_type.h"

void ast_virtual_interface_type_print(ast_virtual_interface_type_t virtual_interface_type) {
    const char *val;

    switch (virtual_interface_type) {
        case AST_VIRTUAL_INTERFACE_TYPE_VIRTUAL: val = "virtual"; break;
        case AST_VIRTUAL_INTERFACE_TYPE_VIRTUAL_INTERFACE: val = "virtual_interface"; break;
    }

    printf("%s", val);
}
