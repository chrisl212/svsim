#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_dynamic_array_new_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_dynamic_array_new_free(ast_node_t *node);

ast_node_t* ast_dynamic_array_new_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression1) {
    ast_dynamic_array_new_t *dynamic_array_new = calloc(1, sizeof(*dynamic_array_new));

    dynamic_array_new->super.print = _ast_dynamic_array_new_print;
    dynamic_array_new->super.free = _ast_dynamic_array_new_free;

    dynamic_array_new->expression0 = expression0;
    dynamic_array_new->expression = expression;
    dynamic_array_new->expression1 = expression1;

    return (ast_node_t *)dynamic_array_new;
}

static void _ast_dynamic_array_new_print(ast_node_t *node, int indent, int indent_incr) {
    ast_dynamic_array_new_t *dynamic_array_new = (ast_dynamic_array_new_t *)node;

    ast_node_print(dynamic_array_new->expression0, indent, indent_incr);
    ast_node_print(dynamic_array_new->expression, indent, indent_incr);
    ast_node_print(dynamic_array_new->expression1, indent, indent_incr);
}

static void _ast_dynamic_array_new_free(ast_node_t *node) {
    ast_dynamic_array_new_t *dynamic_array_new = (ast_dynamic_array_new_t *)node;

    ast_node_free(dynamic_array_new->expression0);
    ast_node_free(dynamic_array_new->expression);
    ast_node_free(dynamic_array_new->expression1);
}
