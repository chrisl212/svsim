#ifndef AST_EXPRESSION_OR_COND_PATTERN_H
#define AST_EXPRESSION_OR_COND_PATTERN_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression0;
    ast_node_t *expression;
    ast_node_t *pattern_no_expression;
    ast_node_t *expression1;
} ast_expression_or_cond_pattern_t;

ast_node_t* ast_expression_or_cond_pattern_new(ast_node_t *expression0, ast_node_t *expression, ast_node_t *pattern_no_expression, ast_node_t *expression1);

#endif
