#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_expression_or_cond_pattern_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_expression_or_cond_pattern_free(ast_node_t *node);

ast_node_t* ast_expression_or_cond_pattern_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *pattern_no_expression, ast_node_t *expression1) {
    ast_expression_or_cond_pattern_t *expression_or_cond_pattern = calloc(1, sizeof(*expression_or_cond_pattern));

    expression_or_cond_pattern->super.print = _ast_expression_or_cond_pattern_print;
    expression_or_cond_pattern->super.free = _ast_expression_or_cond_pattern_free;

    expression_or_cond_pattern->expression0 = expression0;
    expression_or_cond_pattern->expression = expression;
    expression_or_cond_pattern->pattern_no_expression = pattern_no_expression;
    expression_or_cond_pattern->expression1 = expression1;

    return (ast_node_t *)expression_or_cond_pattern;
}

static void _ast_expression_or_cond_pattern_print(ast_node_t *node, int indent, int indent_incr) {
    ast_expression_or_cond_pattern_t *expression_or_cond_pattern = (ast_expression_or_cond_pattern_t *)node;

    ast_node_print(expression_or_cond_pattern->expression0, indent, indent_incr);
    ast_node_print(expression_or_cond_pattern->expression, indent, indent_incr);
    ast_node_print(expression_or_cond_pattern->pattern_no_expression, indent, indent_incr);
    ast_node_print(expression_or_cond_pattern->expression1, indent, indent_incr);
}

static void _ast_expression_or_cond_pattern_free(ast_node_t *node) {
    ast_expression_or_cond_pattern_t *expression_or_cond_pattern = (ast_expression_or_cond_pattern_t *)node;

    ast_node_free(expression_or_cond_pattern->expression0);
    ast_node_free(expression_or_cond_pattern->expression);
    ast_node_free(expression_or_cond_pattern->pattern_no_expression);
    ast_node_free(expression_or_cond_pattern->expression1);
}
