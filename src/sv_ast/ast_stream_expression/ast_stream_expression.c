#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_stream_expression_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_stream_expression_free(ast_node_t *node);

ast_node_t* ast_stream_expression_new(ast_node_t *expression, ast_node_t *part_select_range) {
    ast_stream_expression_t *stream_expression = calloc(1, sizeof(*stream_expression));

    stream_expression->super.print = _ast_stream_expression_print;
    stream_expression->super.free = _ast_stream_expression_free;

    stream_expression->expression = expression;
    stream_expression->part_select_range = part_select_range;

    return (ast_node_t *)stream_expression;
}

static void _ast_stream_expression_print(ast_node_t *node, int indent, int indent_incr) {
    ast_stream_expression_t *stream_expression = (ast_stream_expression_t *)node;

    ast_node_print(stream_expression->expression, indent, indent_incr);
    ast_node_print(stream_expression->part_select_range, indent, indent_incr);
}

static void _ast_stream_expression_free(ast_node_t *node) {
    ast_stream_expression_t *stream_expression = (ast_stream_expression_t *)node;

    ast_node_free(stream_expression->expression);
    ast_node_free(stream_expression->part_select_range);
}
