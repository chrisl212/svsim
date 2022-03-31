#ifndef AST_PULSE_CONTROL_SPECPARAM_H
#define AST_PULSE_CONTROL_SPECPARAM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *constant_mintypmax_expression;
    ast_node_t *hierarchical_identifier0;
    ast_node_t *constant_mintypmax_expression1;
    ast_node_t *hierarchical_identifier1;
    ast_node_t *constant_mintypmax_expression0;
} ast_pulse_control_specparam_t;

ast_node_t* ast_pulse_control_specparam_new(ast_node_t *constant_mintypmax_expression, ast_node_t *hierarchical_identifier0, ast_node_t *constant_mintypmax_expression1, ast_node_t *hierarchical_identifier1, ast_node_t *constant_mintypmax_expression0);

#endif
