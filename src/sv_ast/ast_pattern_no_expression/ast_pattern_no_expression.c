#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_pattern_no_expression_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_pattern_no_expression_free(ast_node_t *node);

ast_node_t* ast_pattern_no_expression_new(ast_node_t *covered, ast_node_t *in, ast_node_t *identifier, ast_node_t *expression0, ast_node_t *identifier_pattern_list, ast_node_t *variant, ast_node_t *expression1, ast_node_t *pattern_list) {
    ast_pattern_no_expression_t *pattern_no_expression = calloc(1, sizeof(*pattern_no_expression));

    pattern_no_expression->super.print = _ast_pattern_no_expression_print;
    pattern_no_expression->super.free = _ast_pattern_no_expression_free;

    pattern_no_expression->covered = covered;
    pattern_no_expression->in = in;
    pattern_no_expression->identifier = identifier;
    pattern_no_expression->expression0 = expression0;
    pattern_no_expression->identifier_pattern_list = identifier_pattern_list;
    pattern_no_expression->variant = variant;
    pattern_no_expression->expression1 = expression1;
    pattern_no_expression->pattern_list = pattern_list;

    return (ast_node_t *)pattern_no_expression;
}

static void _ast_pattern_no_expression_print(ast_node_t *node, int indent, int indent_incr) {
    ast_pattern_no_expression_t *pattern_no_expression = (ast_pattern_no_expression_t *)node;

    ast_node_print(pattern_no_expression->covered, indent, indent_incr);
    ast_node_print(pattern_no_expression->in, indent, indent_incr);
    ast_node_print(pattern_no_expression->identifier, indent, indent_incr);
    ast_node_print(pattern_no_expression->expression0, indent, indent_incr);
    ast_node_print(pattern_no_expression->identifier_pattern_list, indent, indent_incr);
    ast_node_print(pattern_no_expression->variant, indent, indent_incr);
    ast_node_print(pattern_no_expression->expression1, indent, indent_incr);
    ast_node_print(pattern_no_expression->pattern_list, indent, indent_incr);
}

static void _ast_pattern_no_expression_free(ast_node_t *node) {
    ast_pattern_no_expression_t *pattern_no_expression = (ast_pattern_no_expression_t *)node;

    ast_node_free(pattern_no_expression->covered);
    ast_node_free(pattern_no_expression->in);
    ast_node_free(pattern_no_expression->identifier);
    ast_node_free(pattern_no_expression->expression0);
    ast_node_free(pattern_no_expression->identifier_pattern_list);
    ast_node_free(pattern_no_expression->variant);
    ast_node_free(pattern_no_expression->expression1);
    ast_node_free(pattern_no_expression->pattern_list);
}
