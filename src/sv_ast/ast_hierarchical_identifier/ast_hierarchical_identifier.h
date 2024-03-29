#ifndef AST_HIERARCHICAL_IDENTIFIER_H
#define AST_HIERARCHICAL_IDENTIFIER_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *unpacked_dimension_list;
} ast_hierarchical_identifier_t;

ast_node_t* ast_hierarchical_identifier_new(ast_node_t *identifier, ast_node_t *unpacked_dimension_list);

#endif
