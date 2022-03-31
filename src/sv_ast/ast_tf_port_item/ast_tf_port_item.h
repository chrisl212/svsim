#ifndef AST_TF_PORT_ITEM_H
#define AST_TF_PORT_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *variable_dimension_list;
    ast_node_t *identifier;
    ast_node_t *equals_expression;
    ast_node_t *tf_port_direction;
    ast_node_t *data_type;
} ast_tf_port_item_t;

ast_node_t* ast_tf_port_item_new(ast_node_t *variable_dimension_list, ast_node_t *identifier, ast_node_t *equals_expression, ast_node_t *tf_port_direction, ast_node_t *data_type);

#endif
