#ifndef AST_MODPORT_SIMPLE_PORTS_DECLARATION_H
#define AST_MODPORT_SIMPLE_PORTS_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_port_direction/ast_port_direction.h"

typedef struct {
    ast_node_t super;
    ast_node_t *modport_simple_port;
    ast_port_direction_t port_direction;
} ast_modport_simple_ports_declaration_t;

ast_node_t* ast_modport_simple_ports_declaration_new(ast_node_t *modport_simple_port, ast_port_direction_t port_direction);

#endif
