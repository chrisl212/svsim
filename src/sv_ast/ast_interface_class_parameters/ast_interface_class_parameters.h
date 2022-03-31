#ifndef AST_INTERFACE_CLASS_PARAMETERS_H
#define AST_INTERFACE_CLASS_PARAMETERS_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *parameter_port_list;
    ast_node_t *parameter_value_assignment;
} ast_interface_class_parameters_t;

ast_node_t* ast_interface_class_parameters_new(ast_node_t *parameter_port_list, ast_node_t *parameter_value_assignment);

#endif
