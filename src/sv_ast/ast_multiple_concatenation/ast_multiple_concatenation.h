#ifndef AST_MULTIPLE_CONCATENATION_H
#define AST_MULTIPLE_CONCATENATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *concatenation;
    ast_node_t *expression;
} ast_multiple_concatenation_t;

ast_node_t* ast_multiple_concatenation_new(ast_node_t *concatenation, ast_node_t *expression);

#endif
