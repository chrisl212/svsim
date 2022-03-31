#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_property_instance_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_property_instance_free(ast_node_t *node);

ast_node_t* ast_property_instance_new(ast_node_t *ps_or_hierarchical_identifier, ast_node_t *property_argument_list) {
    ast_property_instance_t *property_instance = calloc(1, sizeof(*property_instance));

    property_instance->super.print = _ast_property_instance_print;
    property_instance->super.free = _ast_property_instance_free;

    property_instance->ps_or_hierarchical_identifier = ps_or_hierarchical_identifier;
    property_instance->property_argument_list = property_argument_list;

    return (ast_node_t *)property_instance;
}

static void _ast_property_instance_print(ast_node_t *node, int indent, int indent_incr) {
    ast_property_instance_t *property_instance = (ast_property_instance_t *)node;

    ast_node_print(property_instance->ps_or_hierarchical_identifier, indent, indent_incr);
    ast_node_print(property_instance->property_argument_list, indent, indent_incr);
}

static void _ast_property_instance_free(ast_node_t *node) {
    ast_property_instance_t *property_instance = (ast_property_instance_t *)node;

    ast_node_free(property_instance->ps_or_hierarchical_identifier);
    ast_node_free(property_instance->property_argument_list);
}
