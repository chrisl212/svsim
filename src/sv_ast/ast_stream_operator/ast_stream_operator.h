#ifndef AST_STREAM_OPERATOR_H
#define AST_STREAM_OPERATOR_H

typedef enum {
    AST_STREAM_OPERATOR_TOK_BIT_SL,
    AST_STREAM_OPERATOR_TOK_BIT_SR
} ast_stream_operator_t;

void ast_stream_operator_print(ast_stream_operator_t stream_operator);

#endif
