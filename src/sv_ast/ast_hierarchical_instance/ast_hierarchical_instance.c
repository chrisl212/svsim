#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_hierarchical_instance_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_hierarchical_instance_free(ast_node_t *node);

ast_node_t* ast_hierarchical_instance_new(ast_node_t *name_of_instance, ast_node_t *ordered_port_connection_list, ast_node_t *named_port_connection_list) {
    ast_hierarchical_instance_t *hierarchical_instance = calloc(1, sizeof(*hierarchical_instance));

    hierarchical_instance->super.print = _ast_hierarchical_instance_print;
    hierarchical_instance->super.free = _ast_hierarchical_instance_free;

    hierarchical_instance->name_of_instance = name_of_instance;
    hierarchical_instance->ordered_port_connection_list = ordered_port_connection_list;
    hierarchical_instance->named_port_connection_list = named_port_connection_list;

    return (ast_node_t *)hierarchical_instance;
}

static void _ast_hierarchical_instance_print(ast_node_t *node, int indent, int indent_incr) {
    ast_hierarchical_instance_t *hierarchical_instance = (ast_hierarchical_instance_t *)node;

    ast_node_print(hierarchical_instance->name_of_instance, indent, indent_incr);
    ast_node_print(hierarchical_instance->ordered_port_connection_list, indent, indent_incr);
    ast_node_print(hierarchical_instance->named_port_connection_list, indent, indent_incr);
}

static void _ast_hierarchical_instance_free(ast_node_t *node) {
    ast_hierarchical_instance_t *hierarchical_instance = (ast_hierarchical_instance_t *)node;

    ast_node_free(hierarchical_instance->name_of_instance);
    ast_node_free(hierarchical_instance->ordered_port_connection_list);
    ast_node_free(hierarchical_instance->named_port_connection_list);
}
