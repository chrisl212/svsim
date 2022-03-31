#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_sequence_port_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_sequence_port_item_free(ast_node_t *node);

ast_node_t* ast_sequence_port_item_new(ast_node_t *variable_dimension_list, ast_node_t *sequence_actual_arg, ast_node_t *identifier, ast_node_t *sequence_formal_type, ast_node_t *local_direction) {
    ast_sequence_port_item_t *sequence_port_item = calloc(1, sizeof(*sequence_port_item));

    sequence_port_item->super.print = _ast_sequence_port_item_print;
    sequence_port_item->super.free = _ast_sequence_port_item_free;

    sequence_port_item->variable_dimension_list = variable_dimension_list;
    sequence_port_item->sequence_actual_arg = sequence_actual_arg;
    sequence_port_item->identifier = identifier;
    sequence_port_item->sequence_formal_type = sequence_formal_type;
    sequence_port_item->local_direction = local_direction;

    return (ast_node_t *)sequence_port_item;
}

static void _ast_sequence_port_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_sequence_port_item_t *sequence_port_item = (ast_sequence_port_item_t *)node;

    ast_node_print(sequence_port_item->variable_dimension_list, indent, indent_incr);
    ast_node_print(sequence_port_item->sequence_actual_arg, indent, indent_incr);
    ast_node_print(sequence_port_item->identifier, indent, indent_incr);
    ast_node_print(sequence_port_item->sequence_formal_type, indent, indent_incr);
    ast_node_print(sequence_port_item->local_direction, indent, indent_incr);
}

static void _ast_sequence_port_item_free(ast_node_t *node) {
    ast_sequence_port_item_t *sequence_port_item = (ast_sequence_port_item_t *)node;

    ast_node_free(sequence_port_item->variable_dimension_list);
    ast_node_free(sequence_port_item->sequence_actual_arg);
    ast_node_free(sequence_port_item->identifier);
    ast_node_free(sequence_port_item->sequence_formal_type);
    ast_node_free(sequence_port_item->local_direction);
}
