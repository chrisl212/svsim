#ifndef AST_CONSTANT_EXPRESSION_H
#define AST_CONSTANT_EXPRESSION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *constant_expression0;
    ast_node_t *constant_expression1;
    ast_node_t *constant_expression2;
    ast_node_t *constant_primary;
} ast_constant_expression_t;

ast_node_t* ast_constant_expression_new(ast_node_t *constant_expression0, ast_node_t *constant_expression1, ast_node_t *constant_expression2, ast_node_t *constant_primary);

#endif
