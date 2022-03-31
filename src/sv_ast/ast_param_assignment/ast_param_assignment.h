#ifndef AST_PARAM_ASSIGNMENT_H
#define AST_PARAM_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *constant_param_expression;
} ast_param_assignment_t;

ast_node_t* ast_param_assignment_new(ast_node_t *identifier, ast_node_t *constant_param_expression);

#endif
