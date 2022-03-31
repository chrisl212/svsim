#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_sequential_body_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_sequential_body_free(ast_node_t *node);

ast_node_t* ast_sequential_body_new(ast_node_t *next_state, ast_node_t *current_state, ast_node_t *seq_input_list) {
    ast_sequential_body_t *sequential_body = calloc(1, sizeof(*sequential_body));

    sequential_body->super.print = _ast_sequential_body_print;
    sequential_body->super.free = _ast_sequential_body_free;

    sequential_body->next_state = next_state;
    sequential_body->current_state = current_state;
    sequential_body->seq_input_list = seq_input_list;

    return (ast_node_t *)sequential_body;
}

static void _ast_sequential_body_print(ast_node_t *node, int indent, int indent_incr) {
    ast_sequential_body_t *sequential_body = (ast_sequential_body_t *)node;

    ast_node_print(sequential_body->next_state, indent, indent_incr);
    ast_node_print(sequential_body->current_state, indent, indent_incr);
    ast_node_print(sequential_body->seq_input_list, indent, indent_incr);
}

static void _ast_sequential_body_free(ast_node_t *node) {
    ast_sequential_body_t *sequential_body = (ast_sequential_body_t *)node;

    ast_node_free(sequential_body->next_state);
    ast_node_free(sequential_body->current_state);
    ast_node_free(sequential_body->seq_input_list);
}
