#ifndef AST_NET_PORT_TYPE_H
#define AST_NET_PORT_TYPE_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_net_type/ast_net_type.h"
#include "sv_ast/ast_signing/ast_signing.h"

typedef struct {
    ast_node_t super;
    ast_net_type_t net_type;
    ast_signing_t signing;
    ast_node_t *data_type;
    ast_node_t *packed_dimension_list;
} ast_net_port_type_t;

ast_node_t* ast_net_port_type_new(ast_net_type_t net_type, ast_signing_t signing, ast_node_t *data_type, ast_node_t *packed_dimension_list);

#endif
