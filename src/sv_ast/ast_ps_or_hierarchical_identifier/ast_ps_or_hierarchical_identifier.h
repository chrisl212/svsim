#ifndef AST_PS_OR_HIERARCHICAL_IDENTIFIER_H
#define AST_PS_OR_HIERARCHICAL_IDENTIFIER_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *ps_identifier;
    ast_node_t *identifier1;
    ast_node_t *hierarchical_identifier;
    ast_node_t *parameter_value_assignment;
    ast_node_t *identifier0;
} ast_ps_or_hierarchical_identifier_t;

ast_node_t* ast_ps_or_hierarchical_identifier_new(ast_node_t *ps_identifier, ast_node_t *identifier1, ast_node_t *hierarchical_identifier, ast_node_t *parameter_value_assignment, ast_node_t *identifier0);

#endif
