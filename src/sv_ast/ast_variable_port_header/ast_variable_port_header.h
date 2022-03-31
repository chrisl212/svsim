#ifndef AST_VARIABLE_PORT_HEADER_H
#define AST_VARIABLE_PORT_HEADER_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_port_direction/ast_port_direction.h"

typedef struct {
    ast_node_t super;
    ast_port_direction_t port_direction;
    ast_node_t *variable_port_type;
} ast_variable_port_header_t;

ast_node_t* ast_variable_port_header_new(ast_port_direction_t port_direction, ast_node_t *variable_port_type);

#endif
