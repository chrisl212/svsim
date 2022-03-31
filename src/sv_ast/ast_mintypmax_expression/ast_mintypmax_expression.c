#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_mintypmax_expression_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_mintypmax_expression_free(ast_node_t *node);

ast_node_t* ast_mintypmax_expression_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression2, ast_node_t *expression1) {
    ast_mintypmax_expression_t *mintypmax_expression = calloc(1, sizeof(*mintypmax_expression));

    mintypmax_expression->super.print = _ast_mintypmax_expression_print;
    mintypmax_expression->super.free = _ast_mintypmax_expression_free;

    mintypmax_expression->expression0 = expression0;
    mintypmax_expression->expression = expression;
    mintypmax_expression->expression2 = expression2;
    mintypmax_expression->expression1 = expression1;

    return (ast_node_t *)mintypmax_expression;
}

static void _ast_mintypmax_expression_print(ast_node_t *node, int indent, int indent_incr) {
    ast_mintypmax_expression_t *mintypmax_expression = (ast_mintypmax_expression_t *)node;

    ast_node_print(mintypmax_expression->expression0, indent, indent_incr);
    ast_node_print(mintypmax_expression->expression, indent, indent_incr);
    ast_node_print(mintypmax_expression->expression2, indent, indent_incr);
    ast_node_print(mintypmax_expression->expression1, indent, indent_incr);
}

static void _ast_mintypmax_expression_free(ast_node_t *node) {
    ast_mintypmax_expression_t *mintypmax_expression = (ast_mintypmax_expression_t *)node;

    ast_node_free(mintypmax_expression->expression0);
    ast_node_free(mintypmax_expression->expression);
    ast_node_free(mintypmax_expression->expression2);
    ast_node_free(mintypmax_expression->expression1);
}
