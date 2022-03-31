#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_net_port_type_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_net_port_type_free(ast_node_t *node);

ast_node_t* ast_net_port_type_new(ast_net_type_t net_type, ast_signing_t signing, ast_node_t *data_type, ast_node_t *packed_dimension_list) {
    ast_net_port_type_t *net_port_type = calloc(1, sizeof(*net_port_type));

    net_port_type->super.print = _ast_net_port_type_print;
    net_port_type->super.free = _ast_net_port_type_free;

    net_port_type->net_type = net_type;
    net_port_type->signing = signing;
    net_port_type->data_type = data_type;
    net_port_type->packed_dimension_list = packed_dimension_list;

    return (ast_node_t *)net_port_type;
}

static void _ast_net_port_type_print(ast_node_t *node, int indent, int indent_incr) {
    ast_net_port_type_t *net_port_type = (ast_net_port_type_t *)node;

    ast_net_type_print(net_port_type->net_type);
    ast_signing_print(net_port_type->signing);
    ast_node_print(net_port_type->data_type, indent, indent_incr);
    ast_node_print(net_port_type->packed_dimension_list, indent, indent_incr);
}

static void _ast_net_port_type_free(ast_node_t *node) {
    ast_net_port_type_t *net_port_type = (ast_net_port_type_t *)node;

    ast_node_free(net_port_type->data_type);
    ast_node_free(net_port_type->packed_dimension_list);
}
