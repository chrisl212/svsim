#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_tf_port_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_tf_port_item_free(ast_node_t *node);

ast_node_t* ast_tf_port_item_new(ast_node_t *variable_dimension_list, ast_node_t *identifier, ast_node_t *equals_expression, ast_node_t *tf_port_direction, ast_node_t *data_type) {
    ast_tf_port_item_t *tf_port_item = calloc(1, sizeof(*tf_port_item));

    tf_port_item->super.print = _ast_tf_port_item_print;
    tf_port_item->super.free = _ast_tf_port_item_free;

    tf_port_item->variable_dimension_list = variable_dimension_list;
    tf_port_item->identifier = identifier;
    tf_port_item->equals_expression = equals_expression;
    tf_port_item->tf_port_direction = tf_port_direction;
    tf_port_item->data_type = data_type;

    return (ast_node_t *)tf_port_item;
}

static void _ast_tf_port_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_tf_port_item_t *tf_port_item = (ast_tf_port_item_t *)node;

    ast_node_print(tf_port_item->variable_dimension_list, indent, indent_incr);
    ast_node_print(tf_port_item->identifier, indent, indent_incr);
    ast_node_print(tf_port_item->equals_expression, indent, indent_incr);
    ast_node_print(tf_port_item->tf_port_direction, indent, indent_incr);
    ast_node_print(tf_port_item->data_type, indent, indent_incr);
}

static void _ast_tf_port_item_free(ast_node_t *node) {
    ast_tf_port_item_t *tf_port_item = (ast_tf_port_item_t *)node;

    ast_node_free(tf_port_item->variable_dimension_list);
    ast_node_free(tf_port_item->identifier);
    ast_node_free(tf_port_item->equals_expression);
    ast_node_free(tf_port_item->tf_port_direction);
    ast_node_free(tf_port_item->data_type);
}
