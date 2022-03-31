#ifndef AST_BLOCKING_ASSIGNMENT_H
#define AST_BLOCKING_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_assignment_operator/ast_assignment_operator.h"

typedef struct {
    ast_node_t super;
    ast_assignment_operator_t assignment_operator;
    ast_node_t *lvalue;
    ast_node_t *operator_assignment;
    ast_node_t *expression;
    ast_node_t *delay_or_event_control;
    ast_node_t *dynamic_array_new;
    ast_node_t *class_new;
} ast_blocking_assignment_t;

ast_node_t* ast_blocking_assignment_new(ast_assignment_operator_t assignment_operator, ast_node_t *lvalue, ast_node_t *operator_assignment, ast_node_t *expression, ast_node_t *delay_or_event_control, ast_node_t *dynamic_array_new, ast_node_t *class_new);

#endif
