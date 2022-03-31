#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_property_port_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_property_port_item_free(ast_node_t *node);

ast_node_t* ast_property_port_item_new(ast_node_t *property_actual_arg, ast_node_t *local_input, ast_node_t *variable_dimension_list, ast_node_t *property_formal_type, ast_node_t *identifier) {
    ast_property_port_item_t *property_port_item = calloc(1, sizeof(*property_port_item));

    property_port_item->super.print = _ast_property_port_item_print;
    property_port_item->super.free = _ast_property_port_item_free;

    property_port_item->property_actual_arg = property_actual_arg;
    property_port_item->local_input = local_input;
    property_port_item->variable_dimension_list = variable_dimension_list;
    property_port_item->property_formal_type = property_formal_type;
    property_port_item->identifier = identifier;

    return (ast_node_t *)property_port_item;
}

static void _ast_property_port_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_property_port_item_t *property_port_item = (ast_property_port_item_t *)node;

    ast_node_print(property_port_item->property_actual_arg, indent, indent_incr);
    ast_node_print(property_port_item->local_input, indent, indent_incr);
    ast_node_print(property_port_item->variable_dimension_list, indent, indent_incr);
    ast_node_print(property_port_item->property_formal_type, indent, indent_incr);
    ast_node_print(property_port_item->identifier, indent, indent_incr);
}

static void _ast_property_port_item_free(ast_node_t *node) {
    ast_property_port_item_t *property_port_item = (ast_property_port_item_t *)node;

    ast_node_free(property_port_item->property_actual_arg);
    ast_node_free(property_port_item->local_input);
    ast_node_free(property_port_item->variable_dimension_list);
    ast_node_free(property_port_item->property_formal_type);
    ast_node_free(property_port_item->identifier);
}
