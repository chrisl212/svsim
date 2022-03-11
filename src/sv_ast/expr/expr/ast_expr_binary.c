#include <stdlib.h>
#include <stdio.h>
#include "ast_expr_binary.h"

static void _ast_expr_binary_print(ast_node_t *node);
static void _ast_expr_binary_free(ast_node_t *node);
static void _ast_op_bin_print(ast_op_bin_t op);

ast_expr_binary_t* ast_expr_binary_new(ast_expr_t *left, ast_op_bin_t op, ast_expr_t *right) {
    ast_expr_binary_t *expr     = calloc(1, sizeof(*expr));
    ast_node_t *node            = (ast_node_t *)expr;

    node->print                 = _ast_expr_binary_print;
    node->free                  = _ast_expr_binary_free;
    expr->left                  = left;
    expr->op                    = op;
    expr->right                 = right;

    return expr;
}

static void _ast_expr_binary_print(ast_node_t *node) {
    ast_expr_binary_t *expr = (ast_expr_binary_t *)node;

    ast_node_print((ast_node_t *)expr->left);
    _ast_op_bin_print(expr->op);
    ast_node_print((ast_node_t *)expr->right);
}

static void _ast_expr_binary_free(ast_node_t *node) {
    ast_expr_binary_t *expr = (ast_expr_binary_t *)node;

    ast_node_free((ast_node_t *)expr->left);
    ast_node_free((ast_node_t *)expr->right);
}


static void _ast_op_bin_print(ast_op_bin_t op) {
    switch (op) {
        case AST_OP_BIN_PLUS: printf(" + ");
                              break;
    }
}
