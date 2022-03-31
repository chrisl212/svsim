#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_constant_expression_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_constant_expression_free(ast_node_t *node);

ast_node_t* ast_constant_expression_new(ast_node_t *constant_expression0, ast_node_t *constant_expression1, ast_node_t *constant_expression2, ast_node_t *constant_primary) {
    ast_constant_expression_t *constant_expression = calloc(1, sizeof(*constant_expression));

    constant_expression->super.print = _ast_constant_expression_print;
    constant_expression->super.free = _ast_constant_expression_free;

    constant_expression->constant_expression0 = constant_expression0;
    constant_expression->constant_expression1 = constant_expression1;
    constant_expression->constant_expression2 = constant_expression2;
    constant_expression->constant_primary = constant_primary;

    return (ast_node_t *)constant_expression;
}

static void _ast_constant_expression_print(ast_node_t *node, int indent, int indent_incr) {
    ast_constant_expression_t *constant_expression = (ast_constant_expression_t *)node;

    ast_node_print(constant_expression->constant_expression0, indent, indent_incr);
    ast_node_print(constant_expression->constant_expression1, indent, indent_incr);
    ast_node_print(constant_expression->constant_expression2, indent, indent_incr);
    ast_node_print(constant_expression->constant_primary, indent, indent_incr);
}

static void _ast_constant_expression_free(ast_node_t *node) {
    ast_constant_expression_t *constant_expression = (ast_constant_expression_t *)node;

    ast_node_free(constant_expression->constant_expression0);
    ast_node_free(constant_expression->constant_expression1);
    ast_node_free(constant_expression->constant_expression2);
    ast_node_free(constant_expression->constant_primary);
}
