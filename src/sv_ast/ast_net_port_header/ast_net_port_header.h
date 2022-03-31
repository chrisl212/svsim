#ifndef AST_NET_PORT_HEADER_H
#define AST_NET_PORT_HEADER_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_port_direction/ast_port_direction.h"

typedef struct {
    ast_node_t super;
    ast_node_t *net_port_type;
    ast_port_direction_t port_direction;
} ast_net_port_header_t;

ast_node_t* ast_net_port_header_new(ast_node_t *net_port_type, ast_port_direction_t port_direction);

#endif
