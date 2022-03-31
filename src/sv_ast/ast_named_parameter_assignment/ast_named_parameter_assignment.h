#ifndef AST_NAMED_PARAMETER_ASSIGNMENT_H
#define AST_NAMED_PARAMETER_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *param_expression;
} ast_named_parameter_assignment_t;

ast_node_t* ast_named_parameter_assignment_new(ast_node_t *identifier, ast_node_t *param_expression);

#endif
