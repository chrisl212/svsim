#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_net_port_header_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_net_port_header_free(ast_node_t *node);

ast_node_t* ast_net_port_header_new(ast_node_t *net_port_type, ast_port_direction_t port_direction) {
    ast_net_port_header_t *net_port_header = calloc(1, sizeof(*net_port_header));

    net_port_header->super.print = _ast_net_port_header_print;
    net_port_header->super.free = _ast_net_port_header_free;

    net_port_header->net_port_type = net_port_type;
    net_port_header->port_direction = port_direction;

    return (ast_node_t *)net_port_header;
}

static void _ast_net_port_header_print(ast_node_t *node, int indent, int indent_incr) {
    ast_net_port_header_t *net_port_header = (ast_net_port_header_t *)node;

    ast_node_print(net_port_header->net_port_type, indent, indent_incr);
    ast_port_direction_print(net_port_header->port_direction);
}

static void _ast_net_port_header_free(ast_node_t *node) {
    ast_net_port_header_t *net_port_header = (ast_net_port_header_t *)node;

    ast_node_free(net_port_header->net_port_type);
}
