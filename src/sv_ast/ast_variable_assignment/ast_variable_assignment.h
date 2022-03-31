#ifndef AST_VARIABLE_ASSIGNMENT_H
#define AST_VARIABLE_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *lvalue;
    ast_node_t *expression;
} ast_variable_assignment_t;

ast_node_t* ast_variable_assignment_new(ast_node_t *lvalue, ast_node_t *expression);

#endif
