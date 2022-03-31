#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_expression_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_expression_free(ast_node_t *node);

ast_node_t* ast_expression_new(ast_node_t *inc_or_dec_expression, ast_node_t *operator_assignment, ast_node_t *expression0, ast_node_t *identifier, ast_node_t *value_range_list, ast_node_t *expression2, ast_node_t *expression1, ast_node_t *primary) {
    ast_expression_t *expression = calloc(1, sizeof(*expression));

    expression->super.print = _ast_expression_print;
    expression->super.free = _ast_expression_free;

    expression->inc_or_dec_expression = inc_or_dec_expression;
    expression->operator_assignment = operator_assignment;
    expression->expression0 = expression0;
    expression->identifier = identifier;
    expression->value_range_list = value_range_list;
    expression->expression2 = expression2;
    expression->expression1 = expression1;
    expression->primary = primary;

    return (ast_node_t *)expression;
}

static void _ast_expression_print(ast_node_t *node, int indent, int indent_incr) {
    ast_expression_t *expression = (ast_expression_t *)node;

    ast_node_print(expression->inc_or_dec_expression, indent, indent_incr);
    ast_node_print(expression->operator_assignment, indent, indent_incr);
    ast_node_print(expression->expression0, indent, indent_incr);
    ast_node_print(expression->identifier, indent, indent_incr);
    ast_node_print(expression->value_range_list, indent, indent_incr);
    ast_node_print(expression->expression2, indent, indent_incr);
    ast_node_print(expression->expression1, indent, indent_incr);
    ast_node_print(expression->primary, indent, indent_incr);
}

static void _ast_expression_free(ast_node_t *node) {
    ast_expression_t *expression = (ast_expression_t *)node;

    ast_node_free(expression->inc_or_dec_expression);
    ast_node_free(expression->operator_assignment);
    ast_node_free(expression->expression0);
    ast_node_free(expression->identifier);
    ast_node_free(expression->value_range_list);
    ast_node_free(expression->expression2);
    ast_node_free(expression->expression1);
    ast_node_free(expression->primary);
}
