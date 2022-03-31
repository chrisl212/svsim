#ifndef AST_GENVAR_ITERATION_H
#define AST_GENVAR_ITERATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_assignment_operator/ast_assignment_operator.h"

typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_assignment_operator_t assignment_operator;
    ast_node_t *expression;
} ast_genvar_iteration_t;

ast_node_t* ast_genvar_iteration_new(ast_node_t *identifier, ast_assignment_operator_t assignment_operator, ast_node_t *expression);

#endif
