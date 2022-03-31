#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_variable_port_header_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_variable_port_header_free(ast_node_t *node);

ast_node_t* ast_variable_port_header_new(ast_port_direction_t port_direction, ast_node_t *variable_port_type) {
    ast_variable_port_header_t *variable_port_header = calloc(1, sizeof(*variable_port_header));

    variable_port_header->super.print = _ast_variable_port_header_print;
    variable_port_header->super.free = _ast_variable_port_header_free;

    variable_port_header->port_direction = port_direction;
    variable_port_header->variable_port_type = variable_port_type;

    return (ast_node_t *)variable_port_header;
}

static void _ast_variable_port_header_print(ast_node_t *node, int indent, int indent_incr) {
    ast_variable_port_header_t *variable_port_header = (ast_variable_port_header_t *)node;

    ast_port_direction_print(variable_port_header->port_direction);
    ast_node_print(variable_port_header->variable_port_type, indent, indent_incr);
}

static void _ast_variable_port_header_free(ast_node_t *node) {
    ast_variable_port_header_t *variable_port_header = (ast_variable_port_header_t *)node;

    ast_node_free(variable_port_header->variable_port_type);
}
