#ifndef AST_GENERIC_INSTANTIATION_H
#define AST_GENERIC_INSTANTIATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *data;
    ast_node_t *in;
    ast_node_t *parameters;
    ast_node_t *type;
    ast_node_t *data_type;
    ast_node_t *hierarchical_instance_list;
    ast_node_t *handled;
} ast_generic_instantiation_t;

ast_node_t* ast_generic_instantiation_new(ast_node_t *data, ast_node_t *in, ast_node_t *parameters, ast_node_t *type, ast_node_t *data_type, ast_node_t *hierarchical_instance_list, ast_node_t *handled);

#endif
