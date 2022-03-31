#ifndef AST_SPECPARAM_ASSIGNMENT_H
#define AST_SPECPARAM_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *constant_mintypmax_expression;
    ast_node_t *identifier;
    ast_node_t *pulse_control_specparam;
} ast_specparam_assignment_t;

ast_node_t* ast_specparam_assignment_new(ast_node_t *constant_mintypmax_expression, ast_node_t *identifier, ast_node_t *pulse_control_specparam);

#endif
