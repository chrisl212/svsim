#ifndef AST_MINTYPMAX_EXPRESSION_LIST_2_H
#define AST_MINTYPMAX_EXPRESSION_LIST_2_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *mintypmax_expression;
    ast_node_t *mintypmax_expression0;
    ast_node_t *mintypmax_expression1;
} ast_mintypmax_expression_list_2_t;

ast_node_t* ast_mintypmax_expression_list_2_new(ast_node_t *mintypmax_expression, ast_node_t *mintypmax_expression0, ast_node_t *mintypmax_expression1);

#endif
