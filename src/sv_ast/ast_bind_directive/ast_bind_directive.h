#ifndef AST_BIND_DIRECTIVE_H
#define AST_BIND_DIRECTIVE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *hierarchical_identifier;
    ast_node_t *generic_instantiation;
} ast_bind_directive_t;

ast_node_t* ast_bind_directive_new(ast_node_t *hierarchical_identifier, ast_node_t *generic_instantiation);

#endif
