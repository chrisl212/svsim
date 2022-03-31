#ifndef AST_HIERARCHICAL_INSTANCE_H
#define AST_HIERARCHICAL_INSTANCE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *name_of_instance;
    ast_node_t *ordered_port_connection_list;
    ast_node_t *named_port_connection_list;
} ast_hierarchical_instance_t;

ast_node_t* ast_hierarchical_instance_new(ast_node_t *name_of_instance, ast_node_t *ordered_port_connection_list, ast_node_t *named_port_connection_list);

#endif
