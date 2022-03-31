#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_expression_or_dist_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_expression_or_dist_free(ast_node_t *node);

ast_node_t* ast_expression_or_dist_new(ast_node_t *dist_list, ast_node_t *expression) {
    ast_expression_or_dist_t *expression_or_dist = calloc(1, sizeof(*expression_or_dist));

    expression_or_dist->super.print = _ast_expression_or_dist_print;
    expression_or_dist->super.free = _ast_expression_or_dist_free;

    expression_or_dist->dist_list = dist_list;
    expression_or_dist->expression = expression;

    return (ast_node_t *)expression_or_dist;
}

static void _ast_expression_or_dist_print(ast_node_t *node, int indent, int indent_incr) {
    ast_expression_or_dist_t *expression_or_dist = (ast_expression_or_dist_t *)node;

    ast_node_print(expression_or_dist->dist_list, indent, indent_incr);
    ast_node_print(expression_or_dist->expression, indent, indent_incr);
}

static void _ast_expression_or_dist_free(ast_node_t *node) {
    ast_expression_or_dist_t *expression_or_dist = (ast_expression_or_dist_t *)node;

    ast_node_free(expression_or_dist->dist_list);
    ast_node_free(expression_or_dist->expression);
}
