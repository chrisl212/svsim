#ifndef AST_CONSTANT_MINTYPMAX_EXPRESSION_H
#define AST_CONSTANT_MINTYPMAX_EXPRESSION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression0;
    ast_node_t *expression;
    ast_node_t *expression2;
    ast_node_t *expression1;
} ast_constant_mintypmax_expression_t;

ast_node_t* ast_constant_mintypmax_expression_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *expression2, ast_node_t *expression1);

#endif
