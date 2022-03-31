#ifndef AST_VALUE_RANGE_H
#define AST_VALUE_RANGE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression0;
    ast_node_t *expression;
    ast_node_t *expression1;
} ast_value_range_t;

ast_node_t* ast_value_range_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression1);

#endif
