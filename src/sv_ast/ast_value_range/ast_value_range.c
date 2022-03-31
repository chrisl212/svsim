#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_value_range_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_value_range_free(ast_node_t *node);

ast_node_t* ast_value_range_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression1) {
    ast_value_range_t *value_range = calloc(1, sizeof(*value_range));

    value_range->super.print = _ast_value_range_print;
    value_range->super.free = _ast_value_range_free;

    value_range->expression0 = expression0;
    value_range->expression = expression;
    value_range->expression1 = expression1;

    return (ast_node_t *)value_range;
}

static void _ast_value_range_print(ast_node_t *node, int indent, int indent_incr) {
    ast_value_range_t *value_range = (ast_value_range_t *)node;

    ast_node_print(value_range->expression0, indent, indent_incr);
    ast_node_print(value_range->expression, indent, indent_incr);
    ast_node_print(value_range->expression1, indent, indent_incr);
}

static void _ast_value_range_free(ast_node_t *node) {
    ast_value_range_t *value_range = (ast_value_range_t *)node;

    ast_node_free(value_range->expression0);
    ast_node_free(value_range->expression);
    ast_node_free(value_range->expression1);
}
