#ifndef AST_EXPRESSION_OR_DIST_H
#define AST_EXPRESSION_OR_DIST_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *dist_list;
    ast_node_t *expression;
} ast_expression_or_dist_t;

ast_node_t* ast_expression_or_dist_new(ast_node_t *dist_list, ast_node_t *expression);

#endif
