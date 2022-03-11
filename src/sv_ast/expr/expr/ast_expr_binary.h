#ifndef EXPR_binary_H
#define EXPR_binary_H

#include "ast_expr.h"

typedef enum {
    AST_OP_BIN_PLUS
} ast_op_bin_t;

typedef struct {
    ast_expr_t   super;
    ast_expr_t * left;
    ast_op_bin_t op;
    ast_expr_t * right;
} ast_expr_binary_t;

ast_expr_binary_t* ast_expr_binary_new(ast_expr_t *left, ast_op_bin_t op, ast_expr_t *right);

#endif
