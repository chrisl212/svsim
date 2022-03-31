#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_streaming_concatenation_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_streaming_concatenation_free(ast_node_t *node);

ast_node_t* ast_streaming_concatenation_new(ast_stream_operator_t stream_operator, ast_node_t *slice_size, ast_node_t *stream_concatenation) {
    ast_streaming_concatenation_t *streaming_concatenation = calloc(1, sizeof(*streaming_concatenation));

    streaming_concatenation->super.print = _ast_streaming_concatenation_print;
    streaming_concatenation->super.free = _ast_streaming_concatenation_free;

    streaming_concatenation->stream_operator = stream_operator;
    streaming_concatenation->slice_size = slice_size;
    streaming_concatenation->stream_concatenation = stream_concatenation;

    return (ast_node_t *)streaming_concatenation;
}

static void _ast_streaming_concatenation_print(ast_node_t *node, int indent, int indent_incr) {
    ast_streaming_concatenation_t *streaming_concatenation = (ast_streaming_concatenation_t *)node;

    ast_stream_operator_print(streaming_concatenation->stream_operator);
    ast_node_print(streaming_concatenation->slice_size, indent, indent_incr);
    ast_node_print(streaming_concatenation->stream_concatenation, indent, indent_incr);
}

static void _ast_streaming_concatenation_free(ast_node_t *node) {
    ast_streaming_concatenation_t *streaming_concatenation = (ast_streaming_concatenation_t *)node;

    ast_node_free(streaming_concatenation->slice_size);
    ast_node_free(streaming_concatenation->stream_concatenation);
}
