#ifndef AST_STREAMING_CONCATENATION_H
#define AST_STREAMING_CONCATENATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_stream_operator/ast_stream_operator.h"

typedef struct {
    ast_node_t super;
    ast_stream_operator_t stream_operator;
    ast_node_t *slice_size;
    ast_node_t *stream_concatenation;
} ast_streaming_concatenation_t;

ast_node_t* ast_streaming_concatenation_new(ast_stream_operator_t stream_operator, ast_node_t *slice_size, ast_node_t *stream_concatenation);

#endif
