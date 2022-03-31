#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_part_select_range_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_part_select_range_free(ast_node_t *node);

ast_node_t* ast_part_select_range_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression1) {
    ast_part_select_range_t *part_select_range = calloc(1, sizeof(*part_select_range));

    part_select_range->super.print = _ast_part_select_range_print;
    part_select_range->super.free = _ast_part_select_range_free;

    part_select_range->expression0 = expression0;
    part_select_range->expression = expression;
    part_select_range->expression1 = expression1;

    return (ast_node_t *)part_select_range;
}

static void _ast_part_select_range_print(ast_node_t *node, int indent, int indent_incr) {
    ast_part_select_range_t *part_select_range = (ast_part_select_range_t *)node;

    ast_node_print(part_select_range->expression0, indent, indent_incr);
    ast_node_print(part_select_range->expression, indent, indent_incr);
    ast_node_print(part_select_range->expression1, indent, indent_incr);
}

static void _ast_part_select_range_free(ast_node_t *node) {
    ast_part_select_range_t *part_select_range = (ast_part_select_range_t *)node;

    ast_node_free(part_select_range->expression0);
    ast_node_free(part_select_range->expression);
    ast_node_free(part_select_range->expression1);
}
