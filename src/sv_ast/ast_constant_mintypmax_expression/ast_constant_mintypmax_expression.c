#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_constant_mintypmax_expression_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_constant_mintypmax_expression_free(ast_node_t *node);

ast_node_t* ast_constant_mintypmax_expression_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression2, ast_node_t *expression1) {
    ast_constant_mintypmax_expression_t *constant_mintypmax_expression = calloc(1, sizeof(*constant_mintypmax_expression));

    constant_mintypmax_expression->super.print = _ast_constant_mintypmax_expression_print;
    constant_mintypmax_expression->super.free = _ast_constant_mintypmax_expression_free;

    constant_mintypmax_expression->expression0 = expression0;
    constant_mintypmax_expression->expression = expression;
    constant_mintypmax_expression->expression2 = expression2;
    constant_mintypmax_expression->expression1 = expression1;

    return (ast_node_t *)constant_mintypmax_expression;
}

static void _ast_constant_mintypmax_expression_print(ast_node_t *node, int indent, int indent_incr) {
    ast_constant_mintypmax_expression_t *constant_mintypmax_expression = (ast_constant_mintypmax_expression_t *)node;

    ast_node_print(constant_mintypmax_expression->expression0, indent, indent_incr);
    ast_node_print(constant_mintypmax_expression->expression, indent, indent_incr);
    ast_node_print(constant_mintypmax_expression->expression2, indent, indent_incr);
    ast_node_print(constant_mintypmax_expression->expression1, indent, indent_incr);
}

static void _ast_constant_mintypmax_expression_free(ast_node_t *node) {
    ast_constant_mintypmax_expression_t *constant_mintypmax_expression = (ast_constant_mintypmax_expression_t *)node;

    ast_node_free(constant_mintypmax_expression->expression0);
    ast_node_free(constant_mintypmax_expression->expression);
    ast_node_free(constant_mintypmax_expression->expression2);
    ast_node_free(constant_mintypmax_expression->expression1);
}
