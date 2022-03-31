#include <stdio.h>
#include "ast_port_direction.h"

void ast_port_direction_print(ast_port_direction_t port_direction) {
    const char *val;

    switch (port_direction) {
        case AST_PORT_DIRECTION_INPUT: val = "input"; break;
        case AST_PORT_DIRECTION_REF: val = "ref"; break;
        case AST_PORT_DIRECTION_OUTPUT: val = "output"; break;
        case AST_PORT_DIRECTION_INOUT: val = "inout"; break;
    }

    printf("%s", val);
}
