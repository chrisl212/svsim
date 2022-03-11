#ifndef EXPR_PRIMARY_H
#define EXPR_PRIMARY_H

#include "ast_expr.h"

typedef struct {
    ast_expr_t  super;
    ast_node_t *primary;
} ast_expr_primary_t;

ast_expr_primary_t* ast_expr_primary_new(ast_node_t *primary);

#endif
