#ifndef AST_SPECPARAM_DECLARATION_H
#define AST_SPECPARAM_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *specparam_assignment_list;
    ast_node_t *packed_dimension_list;
} ast_specparam_declaration_t;

ast_node_t* ast_specparam_declaration_new(ast_node_t *specparam_assignment_list, ast_node_t *packed_dimension_list);

#endif
