#ifndef AST_SEQUENCE_PORT_ITEM_H
#define AST_SEQUENCE_PORT_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *variable_dimension_list;
    ast_node_t *sequence_actual_arg;
    ast_node_t *identifier;
    ast_node_t *sequence_formal_type;
    ast_node_t *local_direction;
} ast_sequence_port_item_t;

ast_node_t* ast_sequence_port_item_new(ast_node_t *variable_dimension_list, ast_node_t *sequence_actual_arg, ast_node_t *identifier, ast_node_t *sequence_formal_type, ast_node_t *local_direction);

#endif
