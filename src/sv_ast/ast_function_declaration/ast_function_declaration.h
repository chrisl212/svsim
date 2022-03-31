#ifndef AST_FUNCTION_DECLARATION_H
#define AST_FUNCTION_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_lifetime/ast_lifetime.h"

typedef struct {
    ast_node_t super;
    ast_node_t *function_body_declaration;
    ast_lifetime_t lifetime;
} ast_function_declaration_t;

ast_node_t* ast_function_declaration_new(ast_node_t *function_body_declaration, ast_lifetime_t lifetime);

#endif
