#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_event_expression_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_event_expression_free(ast_node_t *node);

ast_node_t* ast_event_expression_new(ast_node_t *event_expression1, ast_node_t *expression0, ast_edge_identifier_t edge_identifier, ast_node_t *expression, ast_node_t *event_expression0, ast_node_t *expression1) {
    ast_event_expression_t *event_expression = calloc(1, sizeof(*event_expression));

    event_expression->super.print = _ast_event_expression_print;
    event_expression->super.free = _ast_event_expression_free;

    event_expression->event_expression1 = event_expression1;
    event_expression->expression0 = expression0;
    event_expression->edge_identifier = edge_identifier;
    event_expression->expression = expression;
    event_expression->event_expression0 = event_expression0;
    event_expression->expression1 = expression1;

    return (ast_node_t *)event_expression;
}

static void _ast_event_expression_print(ast_node_t *node, int indent, int indent_incr) {
    ast_event_expression_t *event_expression = (ast_event_expression_t *)node;

    ast_node_print(event_expression->event_expression1, indent, indent_incr);
    ast_node_print(event_expression->expression0, indent, indent_incr);
    ast_edge_identifier_print(event_expression->edge_identifier);
    ast_node_print(event_expression->expression, indent, indent_incr);
    ast_node_print(event_expression->event_expression0, indent, indent_incr);
    ast_node_print(event_expression->expression1, indent, indent_incr);
}

static void _ast_event_expression_free(ast_node_t *node) {
    ast_event_expression_t *event_expression = (ast_event_expression_t *)node;

    ast_node_free(event_expression->event_expression1);
    ast_node_free(event_expression->expression0);
    ast_node_free(event_expression->expression);
    ast_node_free(event_expression->event_expression0);
    ast_node_free(event_expression->expression1);
}
