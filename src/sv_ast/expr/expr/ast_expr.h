#ifndef AST_EXPR_H
#define AST_EXPR_H

#include "sv_ast/ast_node.h"

typedef struct {
    ast_node_t super;
} ast_expr_t;

#include "ast_expr_primary.h"
#include "ast_expr_binary.h"

#endif
