#ifndef AST_ANSI_PORT_DECLARATION_H
#define AST_ANSI_PORT_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_port_direction/ast_port_direction.h"

typedef struct {
    ast_node_t super;
    ast_node_t *variable_dimension_list;
    ast_node_t *identifier;
    ast_node_t *expression;
    ast_node_t *net_port_header;
    ast_node_t *variable_port_header;
    ast_node_t *unpacked_dimension_list;
    ast_port_direction_t port_direction;
} ast_ansi_port_declaration_t;

ast_node_t* ast_ansi_port_declaration_new(ast_node_t *variable_dimension_list, ast_node_t *identifier, ast_node_t *expression, ast_node_t *net_port_header, ast_node_t *variable_port_header, ast_node_t *unpacked_dimension_list, ast_port_direction_t port_direction);

#endif
