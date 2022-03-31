#ifndef AST_OPERATOR_ASSIGNMENT_H
#define AST_OPERATOR_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_assignment_operator/ast_assignment_operator.h"

typedef struct {
    ast_node_t super;
    ast_node_t *lvalue;
    ast_assignment_operator_t assignment_operator;
    ast_node_t *expression;
} ast_operator_assignment_t;

ast_node_t* ast_operator_assignment_new(ast_node_t *lvalue, ast_assignment_operator_t assignment_operator, ast_node_t *expression);

#endif
