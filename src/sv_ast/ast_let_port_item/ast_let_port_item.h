#ifndef AST_LET_PORT_ITEM_H
#define AST_LET_PORT_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *expression;
    ast_node_t *let_formal_type;
    ast_node_t *variable_dimension_list;
} ast_let_port_item_t;

ast_node_t* ast_let_port_item_new(ast_node_t *identifier, ast_node_t *expression, ast_node_t *let_formal_type, ast_node_t *variable_dimension_list);

#endif
