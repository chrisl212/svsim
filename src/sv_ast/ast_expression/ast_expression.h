#ifndef AST_EXPRESSION_H
#define AST_EXPRESSION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *inc_or_dec_expression;
    ast_node_t *operator_assignment;
    ast_node_t *expression0;
    ast_node_t *identifier;
    ast_node_t *value_range_list;
    ast_node_t *expression2;
    ast_node_t *expression1;
    ast_node_t *primary;
} ast_expression_t;

ast_node_t* ast_expression_new(ast_node_t *inc_or_dec_expression, ast_node_t *operator_assignment, ast_node_t *expression0, ast_node_t *identifier, ast_node_t *value_range_list, ast_node_t *expression2, ast_node_t *expression1, ast_node_t *primary);

#endif
