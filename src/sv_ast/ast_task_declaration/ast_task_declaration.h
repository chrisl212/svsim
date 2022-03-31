#ifndef AST_TASK_DECLARATION_H
#define AST_TASK_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_lifetime/ast_lifetime.h"

typedef struct {
    ast_node_t super;
    ast_node_t *task_body_declaration;
    ast_lifetime_t lifetime;
} ast_task_declaration_t;

ast_node_t* ast_task_declaration_new(ast_node_t *task_body_declaration, ast_lifetime_t lifetime);

#endif
