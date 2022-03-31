#ifndef AST_DYNAMIC_ARRAY_NEW_H
#define AST_DYNAMIC_ARRAY_NEW_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression0;
    ast_node_t *expression;
    ast_node_t *expression1;
} ast_dynamic_array_new_t;

ast_node_t* ast_dynamic_array_new_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression1);

#endif
