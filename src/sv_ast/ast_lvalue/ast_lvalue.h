#ifndef AST_LVALUE_H
#define AST_LVALUE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *streaming_concatenation;
    ast_node_t *hierarchical_identifier;
    ast_node_t *concatenation;
    ast_node_t *lvlaues;
} ast_lvalue_t;

ast_node_t* ast_lvalue_new(ast_node_t *streaming_concatenation, ast_node_t *hierarchical_identifier, ast_node_t *concatenation, ast_node_t *lvlaues);

#endif
