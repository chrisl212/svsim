#ifndef AST_DEFPARAM_ASSIGNMENT_H
#define AST_DEFPARAM_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *constant_mintypmax_expression;
    ast_node_t *hierarchical_identifier;
} ast_defparam_assignment_t;

ast_node_t* ast_defparam_assignment_new(ast_node_t *constant_mintypmax_expression, ast_node_t *hierarchical_identifier);

#endif
