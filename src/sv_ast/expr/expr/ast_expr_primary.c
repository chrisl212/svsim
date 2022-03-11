#include <stdlib.h>
#include "ast_expr_primary.h"

static void _ast_expr_primary_print(ast_node_t *node);
static void _ast_expr_primary_free(ast_node_t *node);

ast_expr_primary_t* ast_expr_primary_new(ast_node_t *primary) {
    ast_expr_primary_t *expr    = calloc(1, sizeof(*expr));
    ast_node_t *node            = (ast_node_t *)expr;

    node->print                 = _ast_expr_primary_print;
    node->free                  = _ast_expr_primary_free;
    expr->primary               = primary;

    return expr;
}

static void _ast_expr_primary_print(ast_node_t *node) {
    ast_expr_primary_t *expr = (ast_expr_primary_t *)node;

    ast_node_print(expr->primary);
}

static void _ast_expr_primary_free(ast_node_t *node) {
    ast_expr_primary_t *expr = (ast_expr_primary_t *)node;

    ast_node_free(expr->primary);
}

