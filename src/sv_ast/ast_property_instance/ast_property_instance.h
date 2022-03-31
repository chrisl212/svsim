#ifndef AST_PROPERTY_INSTANCE_H
#define AST_PROPERTY_INSTANCE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *ps_or_hierarchical_identifier;
    ast_node_t *property_argument_list;
} ast_property_instance_t;

ast_node_t* ast_property_instance_new(ast_node_t *ps_or_hierarchical_identifier, ast_node_t *property_argument_list);

#endif
