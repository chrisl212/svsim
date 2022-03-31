#ifndef AST_PROPERTY_PORT_ITEM_H
#define AST_PROPERTY_PORT_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *property_actual_arg;
    ast_node_t *local_input;
    ast_node_t *variable_dimension_list;
    ast_node_t *property_formal_type;
    ast_node_t *identifier;
} ast_property_port_item_t;

ast_node_t* ast_property_port_item_new(ast_node_t *property_actual_arg, ast_node_t *local_input, ast_node_t *variable_dimension_list, ast_node_t *property_formal_type, ast_node_t *identifier);

#endif
