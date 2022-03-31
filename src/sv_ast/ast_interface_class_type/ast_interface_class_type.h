#ifndef AST_INTERFACE_CLASS_TYPE_H
#define AST_INTERFACE_CLASS_TYPE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *ps_or_normal_identifier;
    ast_node_t *parameter_value_assignment;
} ast_interface_class_type_t;

ast_node_t* ast_interface_class_type_new(ast_node_t *ps_or_normal_identifier, ast_node_t *parameter_value_assignment);

#endif
