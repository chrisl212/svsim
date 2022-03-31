#ifndef AST_USE_CLAUSE_H
#define AST_USE_CLAUSE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *hierarchical_identifier;
    ast_node_t *named_parameter_assignment_list;
} ast_use_clause_t;

ast_node_t* ast_use_clause_new(ast_node_t *hierarchical_identifier, ast_node_t *named_parameter_assignment_list);

#endif
