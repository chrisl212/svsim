#ifndef AST_PORT_DIRECTION_H
#define AST_PORT_DIRECTION_H

typedef enum {
    AST_PORT_DIRECTION_INPUT,
    AST_PORT_DIRECTION_REF,
    AST_PORT_DIRECTION_OUTPUT,
    AST_PORT_DIRECTION_INOUT
} ast_port_direction_t;

void ast_port_direction_print(ast_port_direction_t port_direction);

#endif
