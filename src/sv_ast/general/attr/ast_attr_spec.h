#ifndef AST_ATTR_SPEC_H
#define AST_ATTR_SPEC_H

#include "sv_ast/ast.h"
#include "sv_ast/ast_node.h"
#include "sv_ast/general/identifier/ast_identifier.h"
#include "sv_ast/expr/expr/ast_expr.h"

typedef struct {
    ast_node_t          super;
    ast_identifier_t *  identifier;
    ast_expr_t *        expr;
} ast_attr_spec_t;

ast_attr_spec_t* ast_attr_spec_new(ast_identifier_t *identifier, ast_expr_t *expr);

#endif
