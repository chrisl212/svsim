#ifndef AST_VARIABLE_DECL_ASSIGNMENT_H
#define AST_VARIABLE_DECL_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *expression;
    ast_node_t *variable_dimension_list;
} ast_variable_decl_assignment_t;

ast_node_t* ast_variable_decl_assignment_new(ast_node_t *identifier, ast_node_t *expression, ast_node_t *variable_dimension_list);

#endif
